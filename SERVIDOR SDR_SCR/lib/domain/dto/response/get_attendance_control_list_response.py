from lib.domain.entities.attendace_control_lists import AttendanceControlLists

class GetAttendanceControlListResponse:
    def __init__(self, attendanceControlLists: AttendanceControlLists):
        self.__attendanceControlLists = attendanceControlLists

    def getAttendanceControlLists(self) -> AttendanceControlLists:
        return self.__attendanceControlLists