package studentrepository

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/mattn/go-sqlite3" // Necessary for sqlite3
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/domain/entities"
	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/utils"
)

// SQLiteStudentRepository ...
type SQLiteStudentRepository struct {
}

// FindStudents ...
func (sqliteStudentRepository SQLiteStudentRepository) FindStudents(subjectID string, paralelID string) []entities.Student {
	var studentSlice []entities.Student

	database, err := sql.Open("sqlite3", utils.SIAADBPath)
	if err != nil {
		log.Fatal(err)
	}
	defer database.Close()

	query := fmt.Sprintf("SELECT codigo_estudiante FROM Estudiante_Paralelo WHERE codigo_materia = '%s' AND codigo_paralelo = '%s'", subjectID, paralelID)
	rows, err := database.Query(query)
	if err != nil {
		log.Fatal(err)
	}

	for rows.Next() {
		var student entities.Student
		rows.Scan(&student.ID)
		studentSlice = append(studentSlice, student)
	}

	for index := range studentSlice {
		query = fmt.Sprintf("SELECT nombre FROM Persona WHERE codigo = '%s'", studentSlice[index].ID)
		rows, err = database.Query(query)
		if err != nil {
			log.Fatal(err)
		}
		if rows.Next() {
			rows.Scan(&studentSlice[index].Name)
		}
	}

	return studentSlice
}
