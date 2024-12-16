from sqlalchemy import Column, Integer, String, Text
from backend.services.database import Base
from sqlalchemy.orm import Session

class Achievement(Base):
    __tablename__ = "achievements"
    1
    achievement_id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100))
    description = Column(Text)
    coin_reward = Column(Integer)

def achievement_init(db: Session):
        if db.query(Achievement).count() == 0:
            achievements = [
                Achievement(
                    name="Discover 1/5 Plants",
                    description="Congratulations! You've successfully discovered 1 out of 10 plants in the collection.",
                    coin_reward=50
                ),
                Achievement(
                    name="Discover 2/5 Plants",
                    description="Great job! You've identified 3 out of 10 plants in the collection.",
                    coin_reward=150
                ),
                Achievement(
                    name="Discover 3/5 Plants",
                    description="Halfway there! You've discovered 5 out of 10 plants in the collection.",
                    coin_reward=250
                ),
                Achievement(
                    name="Discover 4/5 Plants",
                    description="Amazing! You've identified 7 out of 10 plants in the collection.",
                    coin_reward=350
                ),
                Achievement(
                    name="Discover 5/5 Plants",
                    description="You're a plant expert! You've identified all 10 plants in the collection.",
                    coin_reward=500
                ),
                Achievement(
                    name="Scan 5 Plants",
                    description="Keep it up! You've successfully scanned 5 plants.",
                    coin_reward=100
                ),
                Achievement(
                    name="Scan 10 Plants",
                    description="Great progress! You've successfully scanned 10 plants.",
                    coin_reward=200
                ),
                Achievement(
                    name="Scan 20 Plants",
                    description="Fantastic! You've scanned 20 plants and are building a great collection.",
                    coin_reward=400
                ),
                Achievement(
                    name="Scan 50 Plants",
                    description="Impressive! You've scanned 50 plants, showing your dedication.",
                    coin_reward=1000
                ),
                Achievement(
                    name="Scan 100 Plants",
                    description="Phenomenal achievement! You've scanned 100 plants, reaching a remarkable milestone.",
                    coin_reward=2000
                )
            ]
            db.add_all(achievements)
            db.flush()  # Catat perubahan