from fastapi import FastAPI
from lib.services.database import engine, Base, SessionLocal
from lib.routers import user_router, plant_router, achievement_router, auth_router
from lib.models.__init__ import initialize_data
from starlette.middleware.cors import CORSMiddleware

# Inisialisasi FastAPI
app = FastAPI()

# Menambahkan CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Mengizinkan semua origin (Anda dapat mengganti "*" dengan domain tertentu)
    allow_credentials=True,
    allow_methods=["*"],  # Mengizinkan semua HTTP methods, misalnya GET, POST, PUT, DELETE
    allow_headers=["*"],  # Mengizinkan semua header
)

# Event startup untuk membuat tabel dan menambahkan data awal
@app.on_event("startup")
def on_startup():
    try:
        # Membuat tabel jika belum ada (Comment jika tabel sudah ada)
        # Base.metadata.create_all(bind=engine)
        print("Database tables created.")

        db = SessionLocal()
        print("Database access initialized.")
        try:
            # Menambahkan data awal ke database
            initialize_data(db)
        except Exception as e:
            print(f"Error initializing data: {e}")
        finally:
            db.close()
    except Exception as e:
        print(f"Error during startup: {e}")

# Include Routers
app.include_router(auth_router, prefix="", tags=["Auth"])

app.include_router(user_router, prefix="/users", tags=["Users"])
app.include_router(plant_router, prefix="/plants", tags=["Plants"])
app.include_router(achievement_router, prefix="/achievements", tags=["Achievements"])
