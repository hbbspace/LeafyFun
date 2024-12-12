from sqlalchemy.orm import Session
from sqlalchemy.exc import SQLAlchemyError
from .achievement import Achievement, achievement_init
from .article import Article
from .leaf_scan import LeafScan, leaf_scan_init
from .plant import Plant, plant_init
from .quiz_option import QuizOption, quiz_option_init
from .quiz import Quiz, quiz_init
from .user_achievement import UserAchievement
from .user_plant import UserPlant, user_plan_init
from .user import User, user_init

# Ekspor model agar dapat diimpor langsung dari lib.models
__all__ = ["Achievement", "Article", "LeafScan",
           "Plant", "QuizOption", "Quiz",
           "UserAchievement", "UserPlant", "User"]

def initialize_data(db: Session):
    try:
        user_init(db)
        plant_init(db)
        achievement_init(db)
        quiz_init(db)
        quiz_option_init(db)
        leaf_scan_init(db)
        user_plan_init(db)

        db.commit()  # Simpan perubahan ke database
        print("Initial data successfully added.")
    except SQLAlchemyError as e:
        db.rollback()
        print(f"Error initializing data: {e}")