package response

import "gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/entities"

// GetAttendanceControlListResponse ...
type GetAttendanceControlListResponse struct {
	StudentsPresentSlice                   []entities.Student `json:"students_present_list"`
	StudentsMissingSlice                   []entities.Student `json:"students_missing_list"`
	NumberOfDoubtfulStudents               string             `json:"number_of_doubtful_students"`
	PictureWithFacesDetectedAndNamesBase64 string             `json:"picture_with_faces_detected_and_names_base_64"`
}
