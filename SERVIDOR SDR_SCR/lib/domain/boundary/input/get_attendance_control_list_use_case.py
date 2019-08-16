from abc import ABC, abstractmethod
import asyncio
from lib.domain.dto.request.get_attendance_control_list_request import GetAttendanceControlListRequest

class GetAttendanceControlListUseCase(ABC):
    @abstractmethod
    async def getAttendanceControlList(self, request: GetAttendanceControlListRequest): pass