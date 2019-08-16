package ucbview

import (
	gosocketio "github.com/graarh/golang-socketio"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/presentation/ucb/ucbviewmodel"
)

// UCBGetSubjectsView contains the socketio channel
type UCBGetSubjectsView struct {
	SocketIOChannel *gosocketio.Channel
}

// SendSubjects send the viewmodel
func (ucbGetSubjectsView UCBGetSubjectsView) SendSubjects(model ucbviewmodel.UCBGetSubjectsViewModel) {
	ucbGetSubjectsView.SocketIOChannel.Emit("get_subjects_response", model)
}
