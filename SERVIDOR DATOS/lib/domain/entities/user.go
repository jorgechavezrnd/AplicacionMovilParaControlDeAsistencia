package entities

// User contains the data of the user
type User struct {
	ID       string `json:"id"`
	Username string `josn:"username"`
	Password string `json:"password"`
	Name     string `json:"name"`
}
