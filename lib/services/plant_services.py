from sqlalchemy.orm import Session
from lib.models.plant import Plant
from lib.schemas.plant import PlantOut

def get_plants(db: Session):
    return db.query(Plant).all()

def get_plants_out(db: Session):
    plants = get_plants(db)
    return [PlantOut.from_orm(plant) for plant in plants]