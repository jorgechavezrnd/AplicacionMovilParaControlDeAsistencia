class Student:
    def __init__(self, ID: str, name: str, pictureURL: str):
        self.__ID = ID
        self.__name = name
        self.__pictureURL = pictureURL

    def __str__(self) -> str:
        return f'({self.__ID}, {self.__name}, {self.__pictureURL})'

    def __eq__(self, other):
        return ((self.__ID == other.__ID) and (self.__name == other.__name) and (self.__pictureURL == other.__pictureURL))

    def __hash__(self):
        return hash(f'{self.__ID}{self.__name}{self.__pictureURL}')

    def getID(self) -> str:
        return self.__ID

    def getName(self) -> str:
        return self.__name

    def getPictureURL(self) -> str:
        return self.__pictureURL

    def toJSON(self) -> dict:
        jsonObject = {
            'id': self.__ID,
            'name': self.__name,
            'picture_url': self.__pictureURL
        }

        return jsonObject