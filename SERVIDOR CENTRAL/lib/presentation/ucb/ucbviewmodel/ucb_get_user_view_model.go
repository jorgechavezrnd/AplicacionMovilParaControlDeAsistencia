package ucbviewmodel

// UCBGetUserViewModel contains the user data
type UCBGetUserViewModel struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	Password string `json:"password"`
	Name     string `json:"name"`
}
