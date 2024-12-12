from pydantic import BaseModel

class PlantBase(BaseModel):
    common_name: str
    latin_name: str
    description: str
    fruit_content: str
    fruit_season: str
    region: str
    price_range: str
    # image_file: str

    class Config:
        from_attributes = True


class PlantCreate(PlantBase):
    pass


class PlantRead(PlantBase):
    plant_id: int


class PlantOut(PlantRead):
    class Config:
        from_attributes = True
