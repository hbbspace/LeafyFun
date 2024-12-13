from fastapi import APIRouter, HTTPException, Depends, status
from sqlalchemy.orm import Session
from passlib.context import CryptContext
from backend.models.user import User as UserModel
from backend.schemas.user import UserCreate, UserRead, UserUpdate
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

# @router.get("/quiz")
# async def get_current_user_data(current_user: str = Depends(get_current_user), db: Session = Depends(get_db)):
#     user = db.query(UserModel).filter(UserModel.email == current_user).first()
#     if not user:
#         raise HTTPException(status_code=404, detail="User not found")
#     return {"user_id": user.user_id, "username": user.username, "email": user.email}

# @router.get("/scan")
# async def get_current_user_data(current_user: str = Depends(get_current_user), db: Session = Depends(get_db)):
#     user = db.query(UserModel).filter(UserModel.email == current_user).first()
#     if not user:
#         raise HTTPException(status_code=404, detail="User not found")
#     return {"user_id": user.user_id, "username": user.username, "email": user.email}

# @router.get("/garden")
# async def get_current_user_data(current_user: str = Depends(get_current_user), db: Session = Depends(get_db)):
#     user = db.query(UserModel).filter(UserModel.email == current_user).first()
#     if not user:
#         raise HTTPException(status_code=404, detail="User not found")
#     return {"user_id": user.user_id, "username": user.username, "email": user.email}

# @router.get("/profile")
# async def get_current_user_data(current_user: str = Depends(get_current_user), db: Session = Depends(get_db)):
#     user = db.query(UserModel).filter(UserModel.email == current_user).first()
#     if not user:
#         raise HTTPException(status_code=404, detail="User not found")
#     return {"user_id": user.user_id, "username": user.username, "email": user.email}

@router.put("/update_profile", status_code=status.HTTP_200_OK)
async def update_profile(
    user_update: UserUpdate,
    current_user: str = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Update the current user's profile information.

    Args:
        user_update (UserUpdate): Data to update the user's profile.
        current_user (str): Current user's email from the JWT token.
        db (Session): Database session dependency.

    Returns:
        dict: A success message with updated user details.
    """
    # Fetch current user from the database
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