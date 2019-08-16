package subjectrepository

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/mattn/go-sqlite3" // Necessary for sqlite3
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/entities"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/utils"
)

// SQLiteSubjectRepository implements SubjectRepository
type SQLiteSubjectRepository struct {
}

// FindSubjects search subjects by user id
func (sqliteSubjectRepository SQLiteSubjectRepository) FindSubjects(userID string) []entities.Subject {
	var subjectSlice []entities.Subject

	database, err := sql.Open("sqlite3", utils.SIAADBPath)
	if err != nil {
		log.Fatal(err)
	}
	defer database.Close()

	query := fmt.Sprintf("SELECT codigo, codigo_materia FROM Paralelo WHERE codigo_docente = '%s'", userID)
	rows, err := database.Query(query)
	if err != nil {
		log.Fatal(err)
	}

	for rows.Next() {
		var codigo string
		var codigoMateria string
		rows.Scan(&codigo, &codigoMateria)
		subject := entities.Subject{
			ID:       codigoMateria,
			Parallel: codigo,
		}
		subjectSlice = append(subjectSlice, subject)
	}

	for index := range subjectSlice {
		query = fmt.Sprintf("SELECT nombre FROM Materia WHERE codigo = '%s'", subjectSlice[index].ID)
		rows, err = database.Query(query)
		if err != nil {
			log.Fatal(err)
		}
		if rows.Next() {
			rows.Scan(&subjectSlice[index].Name)
		}
	}

	return subjectSlice
}
