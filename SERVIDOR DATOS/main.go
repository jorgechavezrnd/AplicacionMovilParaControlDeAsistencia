package main

import (
	"log"
	"net/http"
	"os"

	"gitlab.com/jorgechavezrnd/siaasimulador2/lib/presentation/siaa/siaacontroller"

	"github.com/gorilla/mux"
)

func main() {
	router := mux.NewRouter()

	endpointsSetup(router)

	var port string
	if port = os.Getenv("PORT"); len(port) == 0 {
		port = "4000"
	}

	log.Println("Server on port", port)
	log.Fatal(http.ListenAndServe(":"+port, router))
}

//==================ENDPOINTS SETUP======================

func endpointsSetup(router *mux.Router) {
	router.HandleFunc("/getuser", getUserEndpoint).Methods("POST")
	router.HandleFunc("/getpersonpicture/{person_id}", getPersonPictureEndpoint).Methods("GET")
	router.HandleFunc("/getsubjects", getSubjectsEndPoint).Methods("POST")
	router.HandleFunc("/getstudentsofasubject", getStudentsOfASubjectEndPoint).Methods("POST")
}

//===============ENDPOINTS FUNCTIONS====================

func getUserEndpoint(writer http.ResponseWriter, httpRequest *http.Request) {
	log.Println("get user endpoint start")

	controller := siaacontroller.SIAAController{}

	controller.GetUserUseCase(writer, httpRequest)

	log.Println("get user endpoint end")
}

func getPersonPictureEndpoint(writer http.ResponseWriter, httpRequest *http.Request) {
	log.Println("get person picture endpoint start")

	controller := siaacontroller.SIAAController{}

	controller.GetPersonPictureUseCase(writer, httpRequest)

	log.Println("get person picture endpoint end")
}

func getSubjectsEndPoint(writer http.ResponseWriter, httpRequest *http.Request) {
	log.Println("get subjects endpoint start")

	controller := siaacontroller.SIAAController{}

	controller.GetSubjectsUseCase(writer, httpRequest)

	log.Println("get subjects endpoint end")
}

func getStudentsOfASubjectEndPoint(writer http.ResponseWriter, httpRequest *http.Request) {
	log.Println("get students of a subject endpoint start")

	controller := siaacontroller.SIAAController{}

	controller.GetStudentsOfASubjectUseCase(writer, httpRequest)

	log.Println("get students of a subject endpoint end")
}
