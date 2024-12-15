from fastapi import APIRouter, HTTPException, Depends, status
from sqlalchemy.orm import Session
from passlib.context import CryptContext
from backend.models.user import User as UserModel
from backend.schemas.user import UserCreate, UserRead, UserUpdate
from backend.models.user_plant import UserPlant as UserPlantModel
from backend.schemas.user_plant import UserPlantCreate, UserPlantRead
from backend.models.user_plant import UserPlant as UserPlantModel
from backend.schemas.user_plant import UserPlantRead
from backend.models.plant import Plant as PlantModel
from backend.models.leaf_scan import LeafScan as LeafScanModel
from backend.schemas.leaf_scan import LeafScanCreate, LeafScanRead
from backend.services.database import get_db
from backend.services.utils import hash_password, verify_password, verify_jwt_token
from fastapi.security import OAuth2PasswordBearer

router = APIRouter()

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="home")

async def get_current_user(token: str = Depends(oauth2_scheme)):
    try:
        payload = verify_jwt_token(token)
        user_email = payload.get("sub")
        if user_email is None:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid token")
        return user_email
    except Exception:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid or expired token")

# Initialize CryptContext for hashing passwords
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

@router.get("/{user_id}", response_model=UserRead, status_code=status.HTTP_200_OK)
async def read_user(user_id: int, db: Session = Depends(get_db)):
    user = db.query(UserModel).filter(UserModel.user_id == user_id).first()
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return user

@router.get("/home")
async def get_current_user_data(current_user: str = Depends(get_current_user), db: Session = Depends(get_db)):
    user = db.query(UserModel).filter(UserModel.email == current_user).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return {"user_id": user.user_id, "username": user.username, "email": user.email}

@router.get("/user_plants/{user_id}/{plant_id}", response_model=UserPlantRead)
async def get_user_plant(user_id: int, plant_id: int, db: Session = Depends(get_db)):
    # Query untuk mendapatkan entri UserPlant dengan user_id dan plant_id
    user_plant = db.query(UserPlantModel).filter(
        UserPlantModel.user_id == user_id, UserPlantModel.plant_id == plant_id
    ).first()

    if user_plant is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User does not have this plant."
        )

    # Query untuk mendapatkan informasi dari tabel Plant
    plant = db.query(PlantModel).filter(PlantModel.plant_id == plant_id).first()

    if plant is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Plant data not found."
        )

    # Menggabungkan data dari UserPlant dan Plant
    return UserPlantRead(
        user_plant_id=user_plant.user_plant_id,
        user_id=user_plant.user_id,
        plant_id=user_plant.plant_id,
        date_saved=user_plant.date_saved,
        quiz_score=user_plant.quiz_score,
        common_name=plant.common_name,
        latin_name=plant.latin_name
    )

# Endpoint untuk menambahkan UserPlant
@router.post("/add_user_plant", response_model=UserPlantRead, status_code=status.HTTP_201_CREATED)
async def add_user_plant(user_plant: UserPlantCreate, db: Session = Depends(get_db)):
    # Membuat entri UserPlant baru
    new_user_plant = UserPlantModel(
        user_id=user_plant.user_id,
        plant_id=user_plant.plant_id,
        date_saved=user_plant.date_saved,
        quiz_score=user_plant.quiz_score
    )

    # Menyimpan entri ke dalam database
    db.add(new_user_plant)
    db.commit()
    db.refresh(new_user_plant)

    # Mengambil data tambahan dari tabel Plant untuk response
    plant = db.query(PlantModel).filter(PlantModel.plant_id == new_user_plant.plant_id).first()

    # Menyusun response yang lebih lengkap
    return UserPlantRead(
        user_plant_id=new_user_plant.user_plant_id,
        user_id=new_user_plant.user_id,
        plant_id=new_user_plant.plant_id,
        date_saved=new_user_plant.date_saved,
        quiz_score=new_user_plant.quiz_score,
        common_name=plant.common_name,
        latin_name=plant.latin_name
    )

@router.get("/history/{user_id}", status_code=status.HTTP_200_OK)
async def get_user_history(user_id: int, db: Session = Depends(get_db)):

    history = (
        db.query(LeafScanModel, PlantModel)
        .join(PlantModel, LeafScanModel.plant_id == PlantModel.plant_id)
        .filter(LeafScanModel.user_id == user_id)
        .order_by(LeafScanModel.scan_date.desc())
        .all()
    )

    if not history:
        raise HTTPException(status_code=404, detail="No history found for this user.")

    # Prepare the response
    response = [
        {
            "scan_id": leaf_scan.scan_id,
            "scan_date": leaf_scan.scan_date,
            "plant_name": plant.common_name,
            "accuracy": f"{leaf_scan.confidence_score:.0f}%"
        }
        for leaf_scan, plant in history
    ]

    return {"user_id": user_id, "history": response}


@router.put("/update_profile", status_code=status.HTTP_200_OK)
async def update_profile(
    user_update: UserUpdate,
    current_user: str = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    user = db.query(UserModel).filter(UserModel.email == current_user).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    
    # Update user fields with the provided data
    if user_update.username:
        user.username = user_update.username
    if user_update.email:
        user.email = user_update.email
    if user_update.password:
        user.password = hash_password(user_update.password)

    # Commit the changes to the database
    db.commit()
    db.refresh(user)

    return {"message": "Profile updated successfully", "user": {"user_id": user.user_id, "username": user.username, "email": user.email}}