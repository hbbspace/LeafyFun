from pydantic import BaseModel
from datetime import datetime


class UserPlantBase(BaseModel):
    user_id: int
    plant_id: int


class UserPlantCreate(UserPlantBase):
    pass


class UserPlantOut(UserPlantBase):
    user_plant_id: int
    date_saved: datetime

    class Config:
        orm_mode = True
