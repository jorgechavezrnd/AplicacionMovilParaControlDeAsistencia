from lib.domain.entities.attendace_control_lists import AttendanceControlLists
from lib.domain.entities.student import Student

class UCBGetAttendanceControlListViewModel:
    def __init__(self, attendanceControlLists: AttendanceControlLists):
        self.__attendanceControlLists = attendanceControlLists

    def getAttendanceControlLists(self) -> AttendanceControlLists:
        return self.__attendanceControlLists

    def toJSON(self) -> dict:
        studentsPresentList = self.__attendanceControlLists.getStudentsPresentList()
        studentsMissingList = self.__attendanceControlLists.getStudentsMissingList()

        students_present_list = []
        students_missing_list = []
        number_of_doubtful_students = self.__attendanceControlLists.getNumberOfDoubtfulStudents()
        pictureWithFacesDetectedAndNamesBase64 = self.__attendanceControlLists.getPictureWithFacesDetectedAndNamesBase64()

        for student in studentsPresentList:
            students_present_list.append(student.toJSON())

        for student in studentsMissingList:
            students_missing_list.append(student.toJSON())

        jsonObject = {
            'students_present_list': students_present_list,
            'students_missing_list': students_missing_list,
            'number_of_doubtful_students': number_of_doubtful_students,
            'picture_with_faces_detected_and_names_base_64': pictureWithFacesDetectedAndNamesBase64
        }

        return jsonObject