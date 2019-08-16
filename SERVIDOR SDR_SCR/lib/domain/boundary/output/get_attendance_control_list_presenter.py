from abc import ABC, abstractmethod
import asyncio
from lib.domain.dto.response.get_attendance_control_list_response import GetAttendanceControlListResponse

class GetAttendanceControlListPresenter(ABC):
    @abstractmethod
    async def displayAttendanceControlList(self, response: GetAttendanceControlListResponse): pass