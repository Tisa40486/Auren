import datetime as dt

from pydantic import BaseModel


class LogCreate(BaseModel):
    date : dt.datetime
    comment: str