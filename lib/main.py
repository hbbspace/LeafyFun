from fastapi import FastAPI
from lib.services.database import engine, Base
from lib.routers import user_router, plant_router, achievement_router

# Inisialisasi FastAPI
app = FastAPI()

# Membuat tabel jika belum ada
Base.metadata.create_all(bind=engine)

# Include Routers
app.include_router(user_router, prefix="/users", tags=["Users"])
# app.include_router(plant_router, prefix="/plants", tags=["Plants"])
# app.include_router(achievement_router, prefix="/achievements", tags=["Achievements"])