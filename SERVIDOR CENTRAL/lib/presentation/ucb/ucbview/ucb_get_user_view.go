package ucbview

import (
	gosocketio "github.com/graarh/golang-socketio"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/presentation/ucb/ucbviewmodel"
)

// UCBGetUserView contains the socketio channel
type UCBGetUserView struct {
	SocketIOChannel *gosocketio.Channel
}

// SendUser send the viewmodel
func (ucbGetUserView UCBGetUserView) SendUser(model ucbviewmodel.UCBGetUserViewModel) {
	ucbGetUserView.SocketIOChannel.Emit("get_user_response", model)
}
