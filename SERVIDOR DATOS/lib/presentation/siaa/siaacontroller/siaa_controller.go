package siaacontroller

import (
	"encoding/json"
	"net/http"

	"github.com/gorilla/mux"

	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/dto/request"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/interactors"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/presentation/siaa/siaapresenter"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/presentation/siaa/siaaview"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/repository/picturerepository"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/repository/studentrepository"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/repository/subjectrepository"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/repository/userrepository"
)

// SIAAController initialize all use cases
type SIAAController struct {
}

// GetUserUseCase initialize the use case
func (siaaController SIAAController) GetUserUseCase(writer http.ResponseWriter, httpRequest *http.Request) {
	var getUserRequestModel request.GetUserRequest
	json.NewDecoder(httpRequest.Body).Decode(&getUserRequestModel)

	repository := userrepository.SQLiteUserRepository{}
	view := siaaview.SIAAGetUserView{Writer: writer}
	presenter := siaapresenter.SIAAGetUserPresenter{View: view}
	getUserUseCase := interactors.GetUserInteractor{Repository: repository, Output: presenter}

	getUserUseCase.GetUser(getUserRequestModel)
}

// GetPersonPictureUseCase initialize the use case
func (siaaController SIAAController) GetPersonPictureUseCase(writer http.ResponseWriter, httpRequest *http.Request) {
	params := mux.Vars(httpRequest)
	personID := params["person_id"]

	getPersonPictureRequestModel := request.GetPersonPictureRequest{
		PersonID: personID,
	}

	repository := picturerepository.SQLitePictureRepository{}
	view := siaaview.SIAAGetPersonPictureView{Writer: writer}
	presenter := siaapresenter.SIAAGetPersonPicturePresenter{View: view}
	getPersonPictureUseCase := interactors.GetPersonPictureInteractor{Repository: repository, Output: presenter}

	getPersonPictureUseCase.GetPersonPicture(getPersonPictureRequestModel)
}

// GetSubjectsUseCase initialize the use case
func (siaaController SIAAController) GetSubjectsUseCase(writer http.ResponseWriter, httpRequest *http.Request) {
	var getSubjectsRequestModel request.GetSubjectsRequest
	json.NewDecoder(httpRequest.Body).Decode(&getSubjectsRequestModel)

	repository := subjectrepository.SQLiteSubjectRepository{}
	view := siaaview.SIAAGetSubjectsView{Writer: writer}
	presenter := siaapresenter.SIAAGetSubjectsPresenter{View: view}
	getSubjectsUseCase := interactors.GetSubjectsInteractor{Repository: repository, Output: presenter}

	getSubjectsUseCase.GetSubjects(getSubjectsRequestModel)
}

// GetStudentsOfASubjectUseCase ...
func (siaaController SIAAController) GetStudentsOfASubjectUseCase(writer http.ResponseWriter, httpRequest *http.Request) {
	var getStudentsOfASubjectRequestModel request.GetStudentsOfASubjectRequest
	json.NewDecoder(httpRequest.Body).Decode(&getStudentsOfASubjectRequestModel)

	repository := studentrepository.SQLiteStudentRepository{}
	view := siaaview.SIAAGetStudentsOfASubjectView{Writer: writer}
	presenter := siaapresenter.SIAAGetStudentsOfASubjectPresenter{View: view}
	getStudentsOfASubjectUseCase := interactors.GetStudentsOfASubjectInteractor{Repository: repository, Output: presenter}

	getStudentsOfASubjectUseCase.GetStudents(getStudentsOfASubjectRequestModel)
}
