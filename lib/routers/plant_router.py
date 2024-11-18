from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from lib.models.plant import Plant as PlantModel
from lib.schemas.plant import PlantCreate, PlantRead
from lib.services.database import get_db

router = APIRouter()


@router.post("/", response_model=PlantRead, status_code=status.HTTP_201_CREATED)
async def create_plant(plant: PlantCreate, db: Session = Depends(get_db)):
    new_plant = PlantModel(
        name=plant.name,
        description=plant.description,
        price=plant.price
    )
    db.add(new_plant)
    db.commit()
    db.refresh(new_plant)
    return new_plant


@router.get("/{plant_id}", response_model=PlantRead, status_code=status.HTTP_200_OK)
async def read_plant(plant_id: int, db: Session = Depends(get_db)):
    plant = db.query(PlantModel).filter(PlantModel.plant_id == plant_id).first()
    if plant is None:
        raise HTTPException(status_code=404, detail="Plant not found")
    return plant
