class ProgressResponse:
    def __init__(self, percentage: str):
        self.__percentage = percentage

    def toJSON(self) -> dict:
        jsonObject = {
            'percentage': self.__percentage
        }

        return jsonObject