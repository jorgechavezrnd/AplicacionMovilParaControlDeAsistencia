package response

// GetPersonPictureResponse contains the picture
type GetPersonPictureResponse struct {
	PictureBytes []byte `json:"picture_bytes"`
}
