package userrepository

import (
	"bytes"
	"encoding/json"
	"io/ioutil"
	"log"
	"net/http"

	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/domain/entities"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/utils"
)

// SIAAUserRepository implements UserRepository
type SIAAUserRepository struct {
}

// FindUser search a user by username
func (siaaUserRepository SIAAUserRepository) FindUser(username string) entities.User {
	request := struct {
		Username string `json:"username"`
	}{
		Username: username,
	}

	jsonValue, _ := json.Marshal(request)
	response, err := http.Post(utils.SiaaServerURL+"/getuser", utils.SiaaServerContentType, bytes.NewBuffer(jsonValue))
	if err != nil {
		log.Fatalf("The HTTP request failed with error %s\n", err)
	}

	data, _ := ioutil.ReadAll(response.Body)

	var user entities.User
	json.Unmarshal(data, &user)

	return user
}
