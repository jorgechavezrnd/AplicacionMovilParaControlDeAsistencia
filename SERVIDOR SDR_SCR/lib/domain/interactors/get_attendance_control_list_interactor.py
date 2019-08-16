import asyncio
from lib.domain.boundary.input.get_attendance_control_list_use_case import GetAttendanceControlListUseCase
from lib.domain.dto.response.get_attendance_control_list_response import GetAttendanceControlListResponse
from lib.domain.dto.request.get_attendance_control_list_request import GetAttendanceControlListRequest
from lib.domain.entitygateways.student_repository import StudentRepository
from lib.domain.boundary.output.get_attendance_control_list_presenter import GetAttendanceControlListPresenter
from lib.domain.entities.attendace_control_lists import AttendanceControlLists

class GetAttendanceControlListInteractor(GetAttendanceControlListUseCase):
    def __init__(self, repository: StudentRepository, output: GetAttendanceControlListPresenter):
        self.__repository = repository
        self.__output = output

    async def getAttendanceControlList(self, request: GetAttendanceControlListRequest):
        image = request.getImageBase64()
        studentsList = request.getStudentsList()
        attendanceControlLists = await self.__repository.findStudents(image, studentsList)
        getAttendanceControlListResponse = GetAttendanceControlListResponse(attendanceControlLists)
        await self.__output.displayAttendanceControlList(getAttendanceControlListResponse)