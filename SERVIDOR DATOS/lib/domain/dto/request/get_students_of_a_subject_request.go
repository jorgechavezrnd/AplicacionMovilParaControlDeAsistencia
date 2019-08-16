package request

// GetStudentsOfASubjectRequest ...
type GetStudentsOfASubjectRequest struct {
	SubjectID string `json:"subject_id"`
	ParalelID string `json:"paralel_id"`
}
