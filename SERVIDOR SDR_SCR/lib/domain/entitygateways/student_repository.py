from abc import ABC, abstractmethod
import asyncio
from lib.domain.entities.attendace_control_lists import AttendanceControlLists

class StudentRepository(ABC):
    @abstractmethod
    async def findStudents(self, imageBase64: str, studentPicturesURL: list) -> AttendanceControlLists: pass