class FacesDetectedResponse:
    def __init__(self, numberOfFaces: str, pictureWithFacesDetectedBase64: str):
        self.__numberOfFaces = numberOfFaces
        self.__pictureWithFacesDetectedBase64 = pictureWithFacesDetectedBase64

    def toJSON(self) -> dict:
        jsonObject = {
            'number_of_faces': self.__numberOfFaces,
            'picture_with_faces_detected_base_64': self.__pictureWithFacesDetectedBase64
        }

        return jsonObject