package request

// GetAttendanceControlListRequest ...
type GetAttendanceControlListRequest struct {
	SubjectID   string `json:"subject_id"`
	ParalelID   string `json:"paralel_id"`
	ImageBase64 string `json:"image_base_64"`
}
