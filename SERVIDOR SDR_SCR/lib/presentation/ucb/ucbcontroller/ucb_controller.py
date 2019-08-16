import socketio
import asyncio
from lib.domain.dto.request.get_attendance_control_list_request import GetAttendanceControlListRequest
from lib.repository.studentrepository.face_recognition_student_repository import FaceRecognitionStudentRepository
from lib.presentation.ucb.ucbview.ucb_get_attendance_control_list_view import UCBGetAttendanceControlListView
from lib.presentation.ucb.ucbpresenter.ucb_get_attendance_control_list_presenter import UCBGetAttendanceControlListPresenter
from lib.domain.interactors.get_attendance_control_list_interactor import GetAttendanceControlListInteractor

class UCBController:
    def __init__(self, sio: socketio.AsyncServer, sid):
        self.__sio = sio
        self.__sid = sid

    async def getAttendanceControlListUseCase(self, request: GetAttendanceControlListRequest):
        repository = FaceRecognitionStudentRepository(self.__sio, self.__sid)
        view = UCBGetAttendanceControlListView(self.__sio, self.__sid)
        presenter = UCBGetAttendanceControlListPresenter(view)
        getAttendanceControllUseCase = GetAttendanceControlListInteractor(repository, presenter)
        await getAttendanceControllUseCase.getAttendanceControlList(request)