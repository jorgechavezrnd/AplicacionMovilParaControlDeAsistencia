package subjectrepository

import (
	"bytes"
	"encoding/json"
	"io/ioutil"
	"log"
	"net/http"

	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/entities"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/utils"
)

// SIAASubjectRepository implements SubjectRepository
type SIAASubjectRepository struct {
}

// FindSubjects search subjects by user id
func (siaaSubjectRepository SIAASubjectRepository) FindSubjects(userID string) []entities.Subject {
	request := struct {
		UserID string `json:"user_id"`
	}{
		UserID: userID,
	}

	jsonValue, _ := json.Marshal(request)
	response, err := http.Post(utils.SiaaServerURL+"/getsubjects", utils.SiaaServerContentType, bytes.NewBuffer(jsonValue))
	if err != nil {
		log.Fatalf("The HTTP request failed with error %s\n", err)
	}

	data, _ := ioutil.ReadAll(response.Body)

	var subjects struct {
		SubjectSlice []entities.Subject `json:"subjects"`
	}
	json.Unmarshal(data, &subjects)

	log.Printf("Subjects: %+v\n", subjects)

	return subjects.SubjectSlice
}
