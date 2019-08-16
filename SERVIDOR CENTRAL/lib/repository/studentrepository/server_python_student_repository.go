package studentrepository

import (
	"bytes"
	"encoding/base64"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"math"
	"net/http"
	"sync"
	"time"

	gosocketio "github.com/graarh/golang-socketio"
	"github.com/graarh/golang-socketio/transport"

	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/dto/request"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/dto/response"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/entities"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/utils"
)

// ServerPythonStudentRepository ...
type ServerPythonStudentRepository struct {
	SocketIOChannel *gosocketio.Channel
}

// --------------------------------------------------FUNCTIONS FOR EVENTS------------------------------------------------------

func onServerConnected(client *gosocketio.Client, imageBase64 string, studentList []entities.Student) {
	imageBytes, err := base64.StdEncoding.DecodeString(imageBase64)
	if err != nil {
		panic(err)
	}

	sizeInMb := int(len(imageBytes) / 1000000)
	quantityOfPartsFloat := float64(sizeInMb) / float64(2)
	quantityOfParts := int(math.Ceil(quantityOfPartsFloat))
	first := 0
	sizeToSend := 0
	if quantityOfParts > 0 {
		sizeToSend = int(len(imageBase64) / quantityOfParts)
	}
	last := sizeToSend

	for i := 0; i < quantityOfParts-1; i++ {
		client.Emit("upload_image", request.UploadImageBase64Request{ImageBase64: imageBase64[first:last]})
		first = last
		last = last + sizeToSend
	}

	client.Emit("upload_image", request.UploadImageBase64Request{ImageBase64: imageBase64[first:]})

	request := request.GetAttendanceControlListServerPythonRequest{
		StudentsList: studentList,
	}

	client.Emit("get_attendance_control_list_request", request)
}

func onGetAttendanceControlListResponse(client *gosocketio.Client, response response.GetAttendanceControlListResponse, wg *sync.WaitGroup, attendanceControlList *entities.AttendanceControlList) {
	fmt.Printf("RESPONSE: {'students_present_list': %v, 'students_missing_list': %v, 'number_of_doubtful_students': %v}\n", response.StudentsPresentSlice, response.StudentsMissingSlice, response.NumberOfDoubtfulStudents)

	attendanceControlList.StudentsPresentSlice = response.StudentsPresentSlice
	attendanceControlList.StudentsMissingSlice = response.StudentsMissingSlice
	attendanceControlList.NumberOfDoubtfulStudents = response.NumberOfDoubtfulStudents
	attendanceControlList.PictureWithFacesDetectedAndNamesBase64 = response.PictureWithFacesDetectedAndNamesBase64

	client.Close()
	wg.Done()
}

func onFacesDetectedResponse(response response.FacesDetectedResponse, serverPythonStudentRepository *ServerPythonStudentRepository) {
	fmt.Printf("ON FACES DETECTED RESPONSE, NUMBER OF FACES: %s\n", response.NumberOfFaces)
	serverPythonStudentRepository.SocketIOChannel.Emit("faces_detected_response", response)
}

func onProgressResponse(response response.PogressResponse, serverPythonStudentRepository *ServerPythonStudentRepository) {
	fmt.Printf("ON PRGRESS RESPONSE: %+v\n", response)
	serverPythonStudentRepository.SocketIOChannel.Emit("progress_response", response)
}

// ------------------------------------------------END FUNCTIONS FOR EVENTS------------------------------------------------------

// FindStudents ...
func (serverPythonStudentRepository ServerPythonStudentRepository) FindStudents(imageBase64 string, subjectID string, paralelID string) entities.AttendanceControlList {
	var attendanceControlList entities.AttendanceControlList

	request := struct {
		SubjectID string `json:"subject_id"`
		ParalelID string `json:"paralel_id"`
	}{
		SubjectID: subjectID,
		ParalelID: paralelID,
	}

	jsonValue, err := json.Marshal(request)
	if err != nil {
		log.Fatalf("JSON Marshal error %s\n", err)
	}
	responsePost, err := http.Post(utils.SiaaServerURL+"/getstudentsofasubject", utils.SiaaServerContentType, bytes.NewBuffer(jsonValue))
	if err != nil {
		log.Fatalf("The HTTP request failed with error %s\n", err)
	}
	data, err := ioutil.ReadAll(responsePost.Body)
	if err != nil {
		log.Fatalf("Ioutil ReadAll error %s\n", err)
	}

	var studentSlice struct {
		StudentSlice []entities.Student `json:"students_list"`
	}
	json.Unmarshal(data, &studentSlice)

	log.Printf("Students Slice: %+v\n", studentSlice)

	for index := range studentSlice.StudentSlice {
		// studentSlice.StudentSlice[index].PictureURL = fmt.Sprintf("https://siaasimulador2.herokuapp.com/getpersonpicture/%s", studentSlice.StudentSlice[index].ID)
		// studentSlice.StudentSlice[index].PictureURL = fmt.Sprintf("http://10.0.0.17:4000/getpersonpicture/%s", studentSlice.StudentSlice[index].ID)
		studentSlice.StudentSlice[index].PictureURL = fmt.Sprintf("http://192.168.202.128:4000/getpersonpicture/%s", studentSlice.StudentSlice[index].ID)
	}

	// COMUNICACION CON SERVER PYTHON
	wg := &sync.WaitGroup{}
	wg.Add(1)
	// url := "ws://servidorseminariopython.herokuapp.com/socket.io/?EIO=3&transport=websocket"

	client, err := gosocketio.Dial(
		gosocketio.GetUrl("0.0.0.0", 8080, false),
		// url,
		&transport.WebsocketTransport{
			PingInterval:   600 * time.Second,
			PingTimeout:    600 * time.Second,
			ReceiveTimeout: 600 * time.Second,
			SendTimeout:    600 * time.Second,
			BufferSize:     transport.WsDefaultBufferSize,
		},
	)

	if err != nil {
		log.Fatalf("Dial error: %+v\n", err)
	}

	err = client.On(gosocketio.OnConnection, func(h *gosocketio.Channel) {
		log.Println("Connected")
	})
	if err != nil {
		log.Fatalf("Connection error: %+v\n", err)
	}

	err = client.On(gosocketio.OnDisconnection, func(h *gosocketio.Channel) {
		log.Println("Disconnected")
	})
	if err != nil {
		log.Fatalf("Disconnection error: %+v\n", err)
	}

	err = client.On("server_connected", func(h *gosocketio.Channel, args struct{}) {
		fmt.Println("ON SERVER CONNECTED")
		onServerConnected(client, imageBase64, studentSlice.StudentSlice)
	})
	if err != nil {
		log.Fatalf("server connected error: %+v\n", err)
	}

	err = client.On("get_attendance_control_list_response", func(h *gosocketio.Channel, args response.GetAttendanceControlListResponse) {
		onGetAttendanceControlListResponse(client, args, wg, &attendanceControlList)
	})
	if err != nil {
		log.Fatalf("get attendance control list response error: %+v\n", err)
	}

	err = client.On("faces_detected_response", func(h *gosocketio.Channel, args response.FacesDetectedResponse) {
		onFacesDetectedResponse(args, &serverPythonStudentRepository)
	})
	if err != nil {
		log.Fatalf("faces_detected_response error: %+v\n", err)
	}

	err = client.On("progress_response", func(h *gosocketio.Channel, args response.PogressResponse) {
		onProgressResponse(args, &serverPythonStudentRepository)
	})
	if err != nil {
		log.Fatalf("progress_response error: %+v\n", err)
	}

	wg.Wait()

	return attendanceControlList
}
