from pydantic import BaseModel
from typing import Optional


class PlantBase(BaseModel):
    common_name: str
    latin_name: Optional[str]
    description: Optional[str]
    vitamin_content: Optional[str]
    fruit_type: Optional[str]
    fruit_season: Optional[str]
    region: Optional[str]
    price_range: Optional[str]
    image_file: Optional[str]


class PlantCreate(BaseModel):
    name: str
    description: str
    price: float


class PlantRead(BaseModel):
    plant_id: int
    name: str
    description: str
    price: float


class PlantOut(PlantBase):
    plant_id: int


class Config:
    orm_mode = True
