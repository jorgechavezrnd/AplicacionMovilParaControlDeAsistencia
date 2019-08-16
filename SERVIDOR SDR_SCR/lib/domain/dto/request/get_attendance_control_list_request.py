class GetAttendanceControlListRequest:
    def __init__(self, imageBase64: str, studentsList: list):
        self.__imageBase64 = imageBase64
        self.__studentsList = studentsList

    def getImageBase64(self) -> str:
        return self.__imageBase64

    def getStudentsList(self) -> list:
        return self.__studentsList