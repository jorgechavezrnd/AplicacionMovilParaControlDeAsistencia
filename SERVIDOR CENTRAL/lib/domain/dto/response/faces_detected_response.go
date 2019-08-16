package response

// FacesDetectedResponse ...
type FacesDetectedResponse struct {
	NumberOfFaces                  string `json:"number_of_faces"`
	PictureWithFacesDetectedBase64 string `json:"picture_with_faces_detected_base_64"`
}
