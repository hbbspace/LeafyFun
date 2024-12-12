import os
import numpy as np
from datetime import datetime
from fastapi.responses import JSONResponse
# Menonaktifkan optimasi oneDNN
os.environ['TF_ENABLE_ONEDNN_OPTS'] = '0'
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.image import load_img, img_to_array
from sqlalchemy.orm import Session
from backend.models.plant import Plant as PlantModel
from backend.schemas.plant import PlantCreate, PlantRead
from backend.services.database import get_db
from fastapi import APIRouter, Depends, File, UploadFile, HTTPException, status
from backend.services.plant_services import get_plants

router = APIRouter()

# Endpoint untuk menambahkan tanaman baru
@router.post("/addPlant", response_model=PlantRead, status_code=status.HTTP_201_CREATED)
async def add_user_plant(plant: PlantCreate, db: Session = Depends(get_db)):
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

# Endpoint prediksi
@router.post("/predict/")
async def predict(file: UploadFile = File(...)):

    # Direktori penyimpanan gambar
    UPLOAD_DIR = "assets/"
    os.makedirs(UPLOAD_DIR, exist_ok=True)

    # Load model
    model_path = '../services/LeafyFunModel.h5'
    if not os.path.exists(model_path):
        raise FileNotFoundError(f"Model tidak ditemukan di: {model_path}")
    model = load_model(model_path)

    # Label kelas
    class_names = ['Apple', 'Cherry', 'Grape', 'Strawberry', 'Tomato']

    # Validasi file
    if not file.filename.endswith(('.jpg', '.jpeg', '.png')):
        raise HTTPException(status_code=400, detail="File harus berupa gambar dengan format JPG, JPEG, atau PNG")

    # Simpan file dengan nama unik (menggunakan timestamp)
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    file_path = os.path.join(UPLOAD_DIR, f"{timestamp}_{file.filename}")
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
    if confidence < 0.5:
        response = {
            'plant_id': 0,
            'confidence': float(confidence),
            'message': "Prediksi tidak dapat dilakukan dengan keyakinan yang cukup",
            'file_path': file_path
        }
    else:
        response = {
            'plant_id': int(predicted_index + 1),
            'confidence': float(confidence),
            'predicted_class': class_names[predicted_index],
            'file_path': file_path
        }

    return JSONResponse(content=response)