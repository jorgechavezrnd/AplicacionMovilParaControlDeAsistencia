package main

import (
	"log"
	"net/http"
	"os"

	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/presentation/ucb/ucbcontroller"

	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/dto/request"

	gosocketio "github.com/graarh/golang-socketio"
	"github.com/graarh/golang-socketio/transport"
)

func main() {
	server := gosocketio.NewServer(transport.GetDefaultWebsocketTransport())

	eventsDefinition(server)

	serveMux := http.NewServeMux()
	serveMux.Handle("/", server)

	var port string
	if port = os.Getenv("PORT"); len(port) == 0 {
		port = "3000"
	}

	log.Println("Starting server on port", port)
	log.Fatalln(http.ListenAndServe(":"+port, serveMux))
}

// ====================================EVENTS DEFINITION======================================

func eventsDefinition(server *gosocketio.Server) {
	server.On(gosocketio.OnConnection, func(socketIOChannel *gosocketio.Channel) {
		onConnection(socketIOChannel)
	})

	server.On(gosocketio.OnDisconnection, func(socketIOChannel *gosocketio.Channel) {
		onDisconnection(socketIOChannel)
	})

	server.On("get_user_request", func(socketIOChannel *gosocketio.Channel, request request.GetUserRequest) string {
		onGetUserRequest(socketIOChannel, request)
		return "get user request ended"
	})

	server.On("get_subjects_request", func(socketIOChannel *gosocketio.Channel, request request.GetSubjectsRequest) string {
		onGetSubjectsRequest(socketIOChannel, request)
		return "get subjects request ended"
	})

	server.On("get_attendance_control_list_request", func(socketIOChannel *gosocketio.Channel, request request.GetAttendanceControlListRequest) string {
		onGetAttendanceControlListRequest(socketIOChannel, request)
		return "get attendance control list request ended"
	})
}

// =================================FUNCTIONS OF EACH EVENT===================================

func onConnection(socketIOChannel *gosocketio.Channel) {
	log.Println("Connected")
	socketIOChannel.Emit("server_connected", struct{}{})
}

func onDisconnection(socketIOChannel *gosocketio.Channel) {
	log.Println("Disconnected")
	socketIOChannel.Close()
}

func onGetUserRequest(socketIOChannel *gosocketio.Channel, request request.GetUserRequest) {
	log.Println("get user request start")

	controller := ucbcontroller.UCBController{}

	controller.GetUserUseCase(socketIOChannel, request)

	log.Println("get user request end")
}

func onGetSubjectsRequest(socketIOChannel *gosocketio.Channel, request request.GetSubjectsRequest) {
	log.Println("get subjects request start")

	controller := ucbcontroller.UCBController{}

	controller.GetSubjectsUseCase(socketIOChannel, request)

	log.Println("get subjects request end")
}

func onGetAttendanceControlListRequest(socketIOChannel *gosocketio.Channel, request request.GetAttendanceControlListRequest) {
	log.Println("get attendance control list request start")

	controller := ucbcontroller.UCBController{}

	controller.GetAttendanceControlListUseCase(socketIOChannel, request)

	log.Println("get attendance control list request end")
}
