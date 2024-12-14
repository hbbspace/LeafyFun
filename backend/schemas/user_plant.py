from pydantic import BaseModel
from datetime import datetime


class UserPlantBase(BaseModel):
    user_id: int
    plant_id: int


class UserPlantCreate(UserPlantBase):
    pass


class UserPlantRead(UserPlantBase):
    user_plant_id: int
    date_saved: str
    common_name: str
    latin_name: str


class UserPlantOut(UserPlantRead):
    class Config:
        from_attributes = True