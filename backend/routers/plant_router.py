from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from backend.models.plant import Plant as PlantModel
from backend.schemas.plant import PlantCreate, PlantRead
from backend.services.database import get_db
from backend.services.plant_services import get_plants

router = APIRouter()

# Endpoint untuk menambahkan tanaman baru
@router.post("/", response_model=PlantRead, status_code=status.HTTP_201_CREATED)
async def create_plant(plant: PlantCreate, db: Session = Depends(get_db)):
    new_plant = PlantModel(
        common_name=plant.common_name,
        latin_name=plant.latin_name,
        description=plant.description,
        fruit_content=plant.fruit_content,
        fruit_season=plant.fruit_season,
        region=plant.region,
        price_range=plant.price_range,
        image_file=plant.image_file
    )
    db.add(new_plant)
    db.commit()
    db.refresh(new_plant)
    return new_plant

# Endpoint untuk mendapatkan detail tanaman berdasarkan ID
@router.get("/scanDetail/{plant_id}", response_model=PlantRead, status_code=status.HTTP_200_OK)
async def read_plant_detail(plant_id: int, db: Session = Depends(get_db)):
    # Mengambil detail tanaman berdasarkan plant_id
    plant = db.query(PlantModel).filter(PlantModel.plant_id == plant_id).first()
    
    # Jika tanaman tidak ditemukan, maka akan melemparkan error
    if not plant:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Plant with id {plant_id} not found"
        )
    
    return plant

# Endpoint untuk mendapatkan daftar tanaman
@router.get("/plants/", response_model=list[PlantRead], status_code=status.HTTP_200_OK)
async def read_plants(db: Session = Depends(get_db)):
    plants = get_plants(db)
    return plants