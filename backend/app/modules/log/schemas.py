from pydantic import BaseModel
import datetime as dt

class LogCreate(BaseModel):
    date : dt.datetime
    comment: str