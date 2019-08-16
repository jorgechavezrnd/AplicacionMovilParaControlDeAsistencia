import asyncio
from aiohttp import web
import socketio
import os
from lib.domain.dto.request.get_attendance_control_list_request import GetAttendanceControlListRequest
from lib.presentation.ucb.ucbcontroller.ucb_controller import UCBController
from lib.domain.entities.student import Student

sio = socketio.AsyncServer(async_mode = 'aiohttp', ping_timeout = 600, ping_interval = 600)
app = web.Application()
sio.attach(app)

imagesDict = {}

@sio.on('connect')
async def onConnect(sid, environ):
    print('connected')
    await sio.emit('server_connected', {}, room=sid)

@sio.on('disconnect')
def onDisconnect(sid):
    print('disconnected')

@sio.on('upload_image')
async def onUploadImage(sid, request):
    print('upload image start')
    if sid in imagesDict:
        imagesDict[sid] = imagesDict[sid] + request['image_base_64']
    else:
        imagesDict[sid] = request['image_base_64']
    print('upload image end')

@sio.on('get_attendance_control_list_request')
async def onMessageClient(sid, request):
    print('get attendance contro list request start')

    students_list_json = request['students_list']
    students_list = []

    for student_json in students_list_json:
        students_list.append(Student(student_json['id'], student_json['name'], student_json['picture_url']))

    image_base_64 = imagesDict[sid]
    imagesDict.pop(sid)
    getAttendanceControlListRequest = GetAttendanceControlListRequest(image_base_64, students_list)
    controller = UCBController(sio, sid)

    await controller.getAttendanceControlListUseCase(getAttendanceControlListRequest)

    print('get attendance contro list request end')

if __name__ == '__main__':
    web.run_app(app, port = os.getenv('PORT'))