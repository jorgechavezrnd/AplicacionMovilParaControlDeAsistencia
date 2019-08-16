package picturerepository

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/mattn/go-sqlite3" // Necessary for sqlite3
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/entities"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/utils"
)

// SQLitePictureRepository implements PictureRepository
type SQLitePictureRepository struct {
}

// FindPicture search a picture by person id
func (sqlitePictureRepository SQLitePictureRepository) FindPicture(personID string) entities.Picture {
	picture := entities.Picture{}

	database, err := sql.Open("sqlite3", utils.SIAADBPath)
	if err != nil {
		log.Fatal(err)
	}
	defer database.Close()

	query := fmt.Sprintf("SELECT foto FROM Persona WHERE codigo = '%s'", personID)
	rows, err := database.Query(query)
	if err != nil {
		log.Fatal(err)
	}

	if rows.Next() {
		rows.Scan(&picture.PictureBytes)
	}

	return picture
}
