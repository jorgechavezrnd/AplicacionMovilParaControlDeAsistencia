class AttendanceControlLists:
    def __init__(self, studentsPresentList: list, studentsMissingList: list, numberOfDoubtfulStudents: str, pictureWithFacesDetectedAndNamesBase64: str):
        self.__studentsPresentList = studentsPresentList
        self.__studentsMissingList = studentsMissingList
        self.__numberOfDoubtfulStudents = numberOfDoubtfulStudents
        self.__pictureWithFacesDetectedAndNamesBase64 = pictureWithFacesDetectedAndNamesBase64

    def getStudentsPresentList(self) -> list:
        return self.__studentsPresentList

    def getStudentsMissingList(self) -> list:
        return self.__studentsMissingList

    def getNumberOfDoubtfulStudents(self) -> str:
        return self.__numberOfDoubtfulStudents

    def getPictureWithFacesDetectedAndNamesBase64(self) -> str:
        return self.__pictureWithFacesDetectedAndNamesBase64