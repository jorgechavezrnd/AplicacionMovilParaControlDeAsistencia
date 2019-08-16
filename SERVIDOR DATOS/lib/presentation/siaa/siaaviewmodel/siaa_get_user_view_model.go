package siaaviewmodel

// SIAAGetUserViewModel contains the user data
type SIAAGetUserViewModel struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	Password string `json:"password"`
	Name     string `json:"name"`
}
