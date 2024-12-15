from pydantic import BaseModel
from datetime import datetime


class UserPlantBase(BaseModel):
    user_id: int
    plant_id: int


class UserPlantCreate(UserPlantBase):
    user_plant_id: int
    date_saved: str
    quiz_score: int


class UserPlantRead(UserPlantBase):
    user_plant_id: int
    date_saved: str
    quiz_score: int
    common_name: str
    latin_name: str


class UserPlantOut(UserPlantRead):
    class Config:
        from_attributes = True