import face_recognition
import io
import base64
import skimage.io as s_io
from PIL import Image, ImageDraw
import socketio
import asyncio
from lib.domain.entitygateways.student_repository import StudentRepository
from lib.domain.entities.student import Student
from lib.domain.entities.attendace_control_lists import AttendanceControlLists
from lib.domain.dto.response.faces_detected_response import FacesDetectedResponse
from lib.domain.dto.response.progress_response import ProgressResponse

class FaceRecognitionStudentRepository(StudentRepository):
    def __init__(self, sio: socketio.AsyncServer, sid):
        self.__sio = sio
        self.__sid = sid

    # async def findStudents(self, imageBase64: str, studentsList: list) -> AttendanceControlLists:
    #     image = face_recognition.load_image_file(io.BytesIO(base64.b64decode(imageBase64)))
    #     face_detected_locations = face_recognition.face_locations(image)
    #     pil_image = Image.fromarray(image)
    #     draw = ImageDraw.Draw(pil_image)

    #     for face_location in face_detected_locations:
    #         top, right, bottom, left = face_location
    #         draw.rectangle(((left, top), (right, bottom)), outline=(0, 255, 0))

    #     buffer = io.BytesIO()
    #     pil_image.save(buffer, format='JPEG')
    #     myimage = buffer.getvalue()
    #     pictureWithFacesDetectedBase64 = base64.b64encode(myimage).decode('utf-8')
    #     numberOfFaces = len(face_detected_locations)

    #     faces_detected_response = FacesDetectedResponse(str(numberOfFaces), str(pictureWithFacesDetectedBase64))

    #     await self.__sio.emit('faces_detected_response', faces_detected_response.toJSON(), room = self.__sid)
    #     await self.__sio.sleep(1)

    #     students_present_list = []
    #     students_missing_list = studentsList
    #     number_of_doubtful_students = 0
    #     progress_percentage = 0
    #     index_of_face = 0

    #     for face_location in face_detected_locations:
    #         index_of_face += 1
    #         new_progress_percentage = int((100 * index_of_face) / numberOfFaces)

    #         top, right, bottom, left = face_location
    #         image1_to_be_matched = image[top:bottom, left:right]
    #         face_encoding1 = face_recognition.face_encodings(image1_to_be_matched)
    #         if len(face_encoding1) > 0:
    #             image1_to_be_matched_encoded = face_encoding1[0]
    #         else:
    #             number_of_doubtful_students += 1
    #             if new_progress_percentage > progress_percentage:
    #                 progress_percentage = new_progress_percentage
    #                 progress_response = ProgressResponse(str(progress_percentage))
    #                 await self.__sio.emit('progress_response', progress_response.toJSON(), room = self.__sid)
    #                 await self.__sio.sleep(1)
    #             draw.rectangle(((left, top), (right, bottom)), outline=(255, 0, 0))
    #             name = 'NO RECONOCIDO'
    #             _, text_height = draw.textsize(name)
    #             draw.rectangle(((left, bottom - text_height - 10), (right, bottom)), fill=(255, 0, 0), outline=(0, 0, 255))
    #             draw.text((left + 6, bottom - text_height - 5), name, fill=(255, 255, 255, 255))
    #             continue
    #         for student in studentsList:
    #             image2_to_be_matched = s_io.imread(student.getPictureURL())
    #             face_encoding2 = face_recognition.face_encodings(image2_to_be_matched)
    #             if len(face_encoding2) > 0:
    #                 image2_to_be_matched_encoded = face_encoding2[0]
    #             else:
    #                 if new_progress_percentage > progress_percentage:
    #                     progress_percentage = new_progress_percentage
    #                     progress_response = ProgressResponse(str(progress_percentage))
    #                     await self.__sio.emit('progress_response', progress_response.toJSON(), room = self.__sid)
    #                     await self.__sio.sleep(1)
    #                 continue
    #             result = face_recognition.compare_faces([image1_to_be_matched_encoded], image2_to_be_matched_encoded)

    #             if result[0] == True:
    #                 students_present_list.append(student)
    #                 students_missing_list.remove(student)
    #                 name = student.getName()
    #                 _, text_height = draw.textsize(name)
    #                 draw.rectangle(((left, bottom - text_height - 10), (right, bottom)), fill=(0, 0, 255), outline=(0, 0, 255))
    #                 draw.text((left + 6, bottom - text_height - 5), name, fill=(255, 255, 255, 255))

    #         if new_progress_percentage > progress_percentage:
    #             progress_percentage = new_progress_percentage
    #             progress_response = ProgressResponse(str(progress_percentage))
    #             await self.__sio.emit('progress_response', progress_response.toJSON(), room = self.__sid)
    #             await self.__sio.sleep(1)

    #     del draw

    #     buffer = io.BytesIO()
    #     pil_image.save(buffer, format='JPEG')
    #     myimage = buffer.getvalue()
    #     pictureWithFacesDetectedAndNamesBase64 = base64.b64encode(myimage).decode('utf-8')

    #     return AttendanceControlLists(students_present_list, students_missing_list, str(number_of_doubtful_students), str(pictureWithFacesDetectedAndNamesBase64))
    
    # --------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    async def findStudents(self, imageBase64: str, studentsList: list) -> AttendanceControlLists:
        image = face_recognition.load_image_file(io.BytesIO(base64.b64decode(imageBase64)))
        face_detected_locations = face_recognition.face_locations(image)
        pil_image = Image.fromarray(image)
        draw = ImageDraw.Draw(pil_image)

        print('#------------------------------------------DETECT FACES--------------------------------------------------')
        indexStudent = 0

        for face_location in face_detected_locations:
            top, right, bottom, left = face_location
            indexStudent += 1
            label = f'E. {indexStudent}'
            _, text_height = draw.textsize(label)
            draw.rectangle(((left, top), (right, bottom)), outline=(0, 255, 0), width=2)
            draw.rectangle(((left, bottom - text_height - 10), (right, bottom)), fill=(0, 0, 255), outline=(0, 0, 255))
            draw.text((left + 6, bottom - text_height - 5), label, fill=(255, 255, 255, 255))


        buffer = io.BytesIO()
        pil_image.save(buffer, format='JPEG')
        myimage = buffer.getvalue()
        pictureWithFacesDetectedBase64 = base64.b64encode(myimage).decode('utf-8')
        numberOfFaces = len(face_detected_locations)

        faces_detected_response = FacesDetectedResponse(str(numberOfFaces), str(pictureWithFacesDetectedBase64))

        await self.__sio.emit('faces_detected_response', faces_detected_response.toJSON(), room = self.__sid)
        await self.__sio.sleep(1)

        print('#------------------------------------------FACES 1 ENCODINGS--------------------------------------------')

        faces_1_encodings = {}
        doubtful_students_positions = []
        face_detected_locations_fix = []

        for face_location in face_detected_locations:
            top, right, bottom, left = face_location
            image_to_be_matched = image[top:bottom, left:right]
            face_encoding = face_recognition.face_encodings(image_to_be_matched)
            if len(face_encoding) > 0:
                image_to_be_matched_encoded = face_encoding[0]
                faces_1_encodings[face_location] = image_to_be_matched_encoded
                face_detected_locations_fix.append(face_location)
            else:
                doubtful_students_positions.append(face_location)

        print('#------------------------------------------FACES 2 ENCODINGS--------------------------------------------')

        faces_2_encodings = {}
        studentsListFix = []

        for student in studentsList:
            print(f'{student.getName()} => {student.getPictureURL()}')
            image_to_be_matched = s_io.imread(student.getPictureURL())
            face_encoding = face_recognition.face_encodings(image_to_be_matched)
            if len(face_encoding) > 0:
                image_to_be_matched_encoded = face_encoding[0]
                faces_2_encodings[student] = image_to_be_matched_encoded
                studentsListFix.append(student)
            else:
                print(f'!!!!!!!!NO DEBERIA LLEGAR AQUI, IMAGEN {student.getPictureURL()} DEL SIAA NO SE PUDO CODIFICAR!!!!')

        print('#-------------------------------------------FACES DISTANCE--------------------------------------------')

        faces_distance = {}

        for face_location in face_detected_locations_fix:
            for student in studentsListFix:
                face_distance = face_recognition.face_distance([faces_1_encodings[face_location]], faces_2_encodings[student])
                faces_distance[(face_location, student)] = face_distance[0]

        print('#-------------------------------------------FACE MATCHED--------------------------------------------')

        students_not_used = studentsListFix
        faces_matched = {}

        for face_location in face_detected_locations_fix:
            less_student = None
            less_distance = 1
            for student in studentsListFix:
                actual_distance = faces_distance[(face_location, student)]
                if actual_distance < less_distance:
                    less_student = student
                    less_distance = actual_distance

            if less_distance < 0.58:
                if less_student in students_not_used:
                    faces_matched[face_location] = (less_student, less_distance)
                    students_not_used.remove(less_student)
                else:
                    doubtful_case_face_location = face_location
                    for actual_face_location in faces_matched.keys():
                        actual_value = faces_matched[actual_face_location]
                        if actual_value[0] == less_student:
                            if actual_value[1] > less_distance:
                                doubtful_case_face_location = actual_face_location
                                faces_matched.pop(actual_face_location)
                                faces_matched[actual_face_location] = (less_student, less_distance)

                    doubtful_students_positions.append(doubtful_case_face_location)
            else:
                doubtful_students_positions.append(face_location)

        print('#------------------------------------BUILD ATTENDANCE CONTROL LIST AND IMAGE----------------------')

        students_present_list = []
        students_missing_list = studentsList
        number_of_doubtful_students = len(doubtful_students_positions)

        for face_matched_position in faces_matched.keys():
            print(f'STUDENT {faces_matched[face_matched_position][0].getName()} DISTANCE: {faces_matched[face_matched_position][1]}')
            top, right, bottom, left = face_matched_position
            student = faces_matched[face_matched_position][0]
            # name = f'{student.getName()}({faces_matched[face_matched_position][1]})'
            name = student.getName()
            _, text_height = draw.textsize(name)
            draw.rectangle(((left, bottom - text_height - 10), (right, bottom)), fill=(0, 0, 255), outline=(0, 0, 255))
            draw.text((left + 6, bottom - text_height - 5), name, fill=(255, 255, 255, 255))
            students_present_list.append(student)
            students_missing_list.remove(student)

        for doubtful_case_face_location in doubtful_students_positions:
            top, right, bottom, left = doubtful_case_face_location
            text = 'NO RECONOCIDO'
            _, text_height = draw.textsize(text)
            draw.rectangle(((left, top), (right, bottom)), outline=(255, 0, 0))
            draw.rectangle(((left, bottom - text_height - 10), (right, bottom)), fill=(255, 0, 0), outline=(0, 0, 255))
            draw.text((left + 6, bottom - text_height - 5), text, fill=(255, 255, 255, 255))

        del draw

        buffer = io.BytesIO()
        pil_image.save(buffer, format='JPEG')
        myimage = buffer.getvalue()
        pictureWithFacesDetectedAndNamesBase64 = base64.b64encode(myimage).decode('utf-8')

        return AttendanceControlLists(students_present_list, students_missing_list, str(number_of_doubtful_students), str(pictureWithFacesDetectedAndNamesBase64))