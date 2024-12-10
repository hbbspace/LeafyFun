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
        orm_mode = True  # Menambahkan ini untuk mengonversi objek ORM ke JSON


class PlantCreate(PlantBase):
    pass


class PlantRead(PlantBase):
    plant_id: int


class PlantOut(PlantRead):
    class Config:
        from_attributes = True
