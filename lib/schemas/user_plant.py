from pydantic import BaseModel
from datetime import datetime


class UserPlantBase(BaseModel):
    user_id: int
    plant_id: int


class UserPlantCreate(UserPlantBase):
    pass


class UserPlantRead(UserPlantBase):
    user_plant_id: int
    date_saved: datetime


class UserPlantOut(UserPlantRead):
    class Config:
        from_attributes = True
