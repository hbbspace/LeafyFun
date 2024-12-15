import os
import numpy as np
from typing import List
from datetime import datetime
from fastapi.responses import JSONResponse
# Menonaktifkan optimasi oneDNN
os.environ['TF_ENABLE_ONEDNN_OPTS'] = '0'
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.image import load_img, img_to_array
from sqlalchemy.orm import Session
from backend.models.user_plant import UserPlant as UserPlantModel
from backend.schemas.user_plant import UserPlantCreate, UserPlantRead
from backend.models.leaf_scan import LeafScan as LeafScanModel
from backend.schemas.leaf_scan import LeafScanCreate, LeafScanRead
from backend.models.user_plant import UserPlant as UserPlantModel
from backend.schemas.user_plant import UserPlantRead
from backend.models.plant import Plant as PlantModel
from backend.schemas.plant import PlantCreate, PlantRead
from backend.services.database import get_db
from fastapi import APIRouter, Depends, File, Query, UploadFile, HTTPException, status
from backend.services.plant_services import get_plants

router = APIRouter()

# Endpoint untuk mendapatkan daftar tanaman
@router.get("/plants/", response_model=list[PlantRead], status_code=status.HTTP_200_OK)
async def read_plants(db: Session = Depends(get_db)):
    plants = get_plants(db)
    return plants

# Endpoint untuk mendapatkan user_plant
from sqlalchemy.orm import joinedload

@router.get("/get_user_plants/{user_id}", response_model=List[UserPlantRead], status_code=status.HTTP_200_OK)
async def get_user_plants(user_id: int, db: Session = Depends(get_db)):

    # Join antara tabel UserPlantModel dan PlantModel
    user_plants = (
        db.query(
            UserPlantModel.user_plant_id,
            UserPlantModel.user_id,
            UserPlantModel.plant_id,
            UserPlantModel.date_saved,
            UserPlantModel.quiz_score,
            PlantModel.common_name,
            PlantModel.latin_name
        )
        .join(PlantModel, UserPlantModel.plant_id == PlantModel.plant_id)
        .filter(UserPlantModel.user_id == user_id)
        .all()
    )

    # Jika tidak ditemukan, kembalikan response 404
    if not user_plants:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"No plants found for user with ID {user_id}"
        )

    # Format ulang data agar sesuai dengan response_model
    result = [
        {
            "user_plant_id": user_plant.user_plant_id,
            "user_id": user_plant.user_id,
            "plant_id": user_plant.plant_id,
            "date_saved": user_plant.date_saved,
            "quiz_score": user_plant.quiz_score,
            "common_name": user_plant.common_name,
            "latin_name": user_plant.latin_name
        }
        for user_plant in user_plants
    ]

    return result

# Endpoint untuk mendapatkan detail tanaman berdasarkan ID
@router.get("/scan_detail/{plant_id}", response_model=PlantRead, status_code=status.HTTP_200_OK)
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

@router.post("/add_leaf_scan", response_model=LeafScanRead, status_code=status.HTTP_201_CREATED)
async def add_leaf_scan(leaf_scan: LeafScanCreate, db: Session = Depends(get_db)):
    # Ambil scan_id terakhir dari database
    last_scan = db.query(LeafScanModel).order_by(LeafScanModel.scan_id.desc()).first()

    # Tentukan scan_id baru
    new_scan_id = last_scan.scan_id + 1 if last_scan else 1

    # Buat instance baru untuk tabel LeafScan
    new_leaf_scan = LeafScanModel(
        # scan_id=new_scan_id,  # Gunakan scan_id yang baru
        user_id=leaf_scan.user_id,
        scan_image=leaf_scan.scan_image,
        plant_id=leaf_scan.plant_id,
        # scan_date=datetime.utcnow().strftime("%d-%m-%Y"),
        confidence_score=leaf_scan.confidence_score
    )

    try:
        # Tambahkan data ke database
        db.add(new_leaf_scan)
        db.commit()
        db.refresh(new_leaf_scan)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail="Terjadi kesalahan saat menyimpan data.")

    return new_leaf_scan

# Endpoint prediksi
@router.post("/predict/")
async def predict(file: UploadFile = File(...)):

    # Direktori penyimpanan gambar
    UPLOAD_DIR = "assets/leaf_scan/"
    os.makedirs(UPLOAD_DIR, exist_ok=True)

    # Load model
    model_path = 'backend/services/LeafyFunModel.h5' 
    if not os.path.exists(model_path):
        raise FileNotFoundError(f"Model tidak ditemukan di: {model_path}")
    model = load_model(model_path)

    # Label kelas
    class_names = ['Apple', 'Cherry', 'Grape', 'Strawberry', 'Tomato']

    # Validasi file
    if not file.filename.endswith(('.jpg', '.jpeg', '.png', '.JPG', '.JPEG', '.PNG')):
        raise HTTPException(status_code=400, detail="File harus berupa gambar dengan format JPG, JPEG, atau PNG")

    # Simpan file dengan nama unik (menggunakan timestamp)
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    file_name = f"{timestamp}.jpg"
    file_path = os.path.join(UPLOAD_DIR, file_name)
    with open(file_path, "wb") as f:
        f.write(await file.read())

    # Preprocess gambar
    img = load_img(file_path, target_size=(128, 128))
    img_array = img_to_array(img) / 255.0
    img_array = np.expand_dims(img_array, axis=0)

    # Prediksi
    predictions = model.predict(img_array)
    confidence = np.max(predictions)
    predicted_index = np.argmax(predictions)

    # Cek confidence threshold
    if confidence < 0.8:
        response = {
            'plant_id': 0,
            'confidence': round(float(confidence), 2),
            'message': "Prediksi tidak dapat dilakukan dengan keyakinan yang cukup",
            'file_name': file_name
        }
    else:
        response = {
            'plant_id': int(predicted_index + 1),
            'confidence': round(float(confidence), 2),
            'predicted_class': class_names[predicted_index],
            'file_name': file_name
        }

    return JSONResponse(content=response)
