package ucbview

import (
	gosocketio "github.com/graarh/golang-socketio"
	"gitlab.com/jorgechavezrnd/servidorseminariogo2/lib/presentation/ucb/ucbviewmodel"
)

// UCBGetAttendanceControlListView ...
type UCBGetAttendanceControlListView struct {
	SocketIOChannel *gosocketio.Channel
}

// SendAttendanceControlList ...
func (ucbGetAttendanceControlListView UCBGetAttendanceControlListView) SendAttendanceControlList(model ucbviewmodel.UCBGetAttendanceControlListViewModel) {
	ucbGetAttendanceControlListView.SocketIOChannel.Emit("get_attendance_control_list_response", model)
}
