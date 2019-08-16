import asyncio
from lib.domain.boundary.output.get_attendance_control_list_presenter import GetAttendanceControlListPresenter
from lib.presentation.ucb.ucbviewmodel.ucb_get_attendance_control_list_view_model import UCBGetAttendanceControlListViewModel
from lib.presentation.ucb.ucbview.ucb_get_attendance_control_list_view import UCBGetAttendanceControlListView
from lib.domain.dto.response.get_attendance_control_list_response import GetAttendanceControlListResponse

class UCBGetAttendanceControlListPresenter(GetAttendanceControlListPresenter):
    def __init__(self, view: UCBGetAttendanceControlListView):
        self.__view = view

    async def displayAttendanceControlList(self, response: GetAttendanceControlListResponse):
        model = UCBGetAttendanceControlListViewModel(response.getAttendanceControlLists())
        await self.__view.sendStudentLists(model)