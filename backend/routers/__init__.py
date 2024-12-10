# lib/routers/__init__.py
from .user_router import router as user_router
from .plant_router import router as plant_router
from .achievement_router import router as achievement_router
from .auth_router import router as auth_router

# Ekspor router agar dapat diimpor langsung dari lib.routers
__all__ = ["user_router", "plant_router", "achievement_router", "auth_router"]
