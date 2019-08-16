package ucbcontroller

import (
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/dto/request"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/interactors"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/presentation/ucb/ucbpresenter"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/presentation/ucb/ucbview"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/repository/studentrepository"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/repository/subjectrepository"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/repository/userrepository"

	gosocketio "github.com/graarh/golang-socketio"
)

// UCBController initialize all use cases
type UCBController struct {
}

// GetUserUseCase initialize the use case
func (ucbController UCBController) GetUserUseCase(socketIOChannel *gosocketio.Channel, request request.GetUserRequest) {
	repository := userrepository.SIAAUserRepository{}
	view := ucbview.UCBGetUserView{SocketIOChannel: socketIOChannel}
	presenter := ucbpresenter.UCBGetUserPresenter{View: view}
	getUserUseCase := interactors.GetUserInteractor{Repository: repository, Output: presenter}

	getUserUseCase.GetUser(request)
}

// GetSubjectsUseCase initialize the use case
func (ucbController UCBController) GetSubjectsUseCase(socketIOChannel *gosocketio.Channel, request request.GetSubjectsRequest) {
	repository := subjectrepository.SIAASubjectRepository{}
	view := ucbview.UCBGetSubjectsView{SocketIOChannel: socketIOChannel}
	presenter := ucbpresenter.UCBGetSubjectsPresenter{View: view}
	getSubjectUseCase := interactors.GetSubjectsInteractor{Repository: repository, Output: presenter}

	getSubjectUseCase.GetSubjects(request)
}

// GetAttendanceControlListUseCase ...
func (ucbController UCBController) GetAttendanceControlListUseCase(socketIOChannel *gosocketio.Channel, request request.GetAttendanceControlListRequest) {
	repository := studentrepository.ServerPythonStudentRepository{SocketIOChannel: socketIOChannel}
	view := ucbview.UCBGetAttendanceControlListView{SocketIOChannel: socketIOChannel}
	presenter := ucbpresenter.UCBGetAttendanceControlListPresenter{View: view}
	getAttendanceControlListUseCase := interactors.GetAttendanceControlListInteractor{Repository: repository, Output: presenter}

	getAttendanceControlListUseCase.GetAttendanceControlList(request)
}
