package userrepository

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/mattn/go-sqlite3" // Necessary for sqlite3
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/entities"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/utils"
)

// SQLiteUserRepository implements UserRepository
type SQLiteUserRepository struct {
}

// FindUser search a user by username
func (sqliteUserRepository SQLiteUserRepository) FindUser(username string) entities.User {
	user := entities.User{
		ID:       "",
		Username: "",
		Password: "",
		Name:     "",
	}

	database, err := sql.Open("sqlite3", utils.SIAADBPath)
	if err != nil {
		log.Fatal(err)
	}
	defer database.Close()

	query := fmt.Sprintf("SELECT codigo, nombre_usuario, contrasena FROM Docente WHERE nombre_usuario = '%s'", username)
	rows, err := database.Query(query)
	if err != nil {
		log.Fatal(err)
	}

	if rows.Next() {
		rows.Scan(&user.ID, &user.Username, &user.Password)
	}

	query2 := fmt.Sprintf("SELECT nombre FROM Persona WHERE codigo = '%s'", user.ID)
	rows2, err2 := database.Query(query2)
	if err2 != nil {
		log.Fatal(err2)
	}

	if rows2.Next() {
		rows2.Scan(&user.Name)
	}

	return user
}
