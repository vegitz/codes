from datetime import datetime as dt

class Human:
    def __init__(self, name, birthdate):
        # set the properites
        self.name = name
        self.birthdate = birthdate

    @property
    def age(self):
        # compute age
        delta = dt.now() - dt.fromisoformat(self.birthdate)
        # return age in years
        return delta.days // 365








