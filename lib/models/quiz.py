from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from lib.services.database import Base
from sqlalchemy.orm import Session

class Quiz(Base):
    __tablename__ = "quizzes"

    quiz_id = Column(Integer, primary_key=True, index=True)
    plant_id = Column(Integer, ForeignKey("plants.plant_id"))
    question_text = Column(String(255))

    quiz_options = relationship("QuizOption", back_populates="quiz")

def quiz_init(db: Session):
    if db.query(Quiz).count() == 0:
        # Pertanyaan untuk tanaman Apple
        quizzes = [
            Quiz(
                plant_id=1,
                question_text="What is the primary color of most apple fruits?",
            ),
            Quiz(
                plant_id=1,
                question_text="Which vitamin is most abundant in apples?",
            ),
            Quiz(
                plant_id=1,
                question_text="What part of the apple tree produces fruit?",
            ),
            Quiz(
                plant_id=1,
                question_text="Which of these is a popular variety of apple?",
            ),
            Quiz(
                plant_id=1,
                question_text="Where do apple trees thrive the best?",
            ),
            Quiz(
                plant_id=1,
                question_text="What is the apple fruit's main benefit?",
            ),
            Quiz(
                plant_id=1,
                question_text="How do you best store apples to maintain freshness?",
            ),
            Quiz(
                plant_id=1,
                question_text="How many types of apple varieties exist around the world?",
            ),
            Quiz(
                plant_id=1,
                question_text="What is the average lifespan of an apple tree?",
            ),
            Quiz(
                plant_id=1,
                question_text="When do apple trees typically start bearing fruit?",
            ),
            

            # Pertanyaan untuk tanaman Cherry
            Quiz(
                plant_id=2,
                question_text="What is the primary color of most cherry fruits?",
            ),
            Quiz(
                plant_id=2,
                question_text="What is a significant health benefit of cherries?",
            ),
            Quiz(
                plant_id=2,
                question_text="What is the shape of most cherry fruits?",
            ),
            Quiz(
                plant_id=2,
                question_text="Which type of cherry is used for making cherry pies?",
            ),
            Quiz(
                plant_id=2,
                question_text="Which climate is ideal for growing cherry trees?",
            ),
            Quiz(
                plant_id=2,
                question_text="How long does it typically take for a cherry tree to bear fruit?",
            ),
            Quiz(
                plant_id=2,
                question_text="What is the best way to preserve cherries for long-term storage?",
            ),
            Quiz(
                plant_id=2,
                question_text="What is the major difference between sweet and sour cherries?",
            ),
            Quiz(
                plant_id=2,
                question_text="What is the average lifespan of a cherry tree?",
            ),
            Quiz(
                plant_id=2,
                question_text="Where are cherry trees most commonly grown?",
            ),
        ]
        db.add_all(quizzes)
        db.commit() # Catat Perubahan

