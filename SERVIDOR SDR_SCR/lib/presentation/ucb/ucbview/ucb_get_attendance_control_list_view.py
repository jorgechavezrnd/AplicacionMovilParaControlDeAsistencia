import asyncio
import socketio
from lib.presentation.ucb.ucbviewmodel.ucb_get_attendance_control_list_view_model import UCBGetAttendanceControlListViewModel

class UCBGetAttendanceControlListView:
    def __init__(self, sio: socketio.AsyncServer, sid):
        self.__sio = sio
        self.__sid = sid

    async def sendStudentLists(self, model: UCBGetAttendanceControlListViewModel):
        await self.__sio.emit('get_attendance_control_list_response', model.toJSON(), self.__sid)
        await self.__sio.sleep(1)