package response

// GetUserResponse contains the data of the user
type GetUserResponse struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	Password string `json:"password"`
	Name     string `json:"name"`
}
