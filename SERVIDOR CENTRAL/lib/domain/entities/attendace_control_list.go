package entities

// AttendanceControlList ...
type AttendanceControlList struct {
	StudentsPresentSlice                   []Student `json:"students_present_list"`
	StudentsMissingSlice                   []Student `json:"students_missing_list"`
	NumberOfDoubtfulStudents               string    `json:"number_of_doubtful_students"`
	PictureWithFacesDetectedAndNamesBase64 string    `json:"picture_with_faces_detected_and_names_base_64"`
}
