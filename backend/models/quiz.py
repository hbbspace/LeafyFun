from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from backend.services.database import Base
from sqlalchemy.orm import Session

class Quiz(Base):
    __tablename__ = "quizzes"

    quiz_id = Column(Integer, primary_key=True, index=True)
    plant_id = Column(Integer, ForeignKey("plants.plant_id"))
    question_text = Column(String(255))

    quiz_options = relationship("QuizOption", back_populates="quiz")

def quiz_init(db: Session):
    if db.query(Quiz).count() == 0:
        quizzes = [
            # Pertanyaan untuk tanaman Apple
            Quiz(plant_id=1, question_text="What is the primary color of most apple fruits?",),
            Quiz(plant_id=1, question_text="Which vitamin is most abundant in apples?",),
            Quiz(plant_id=1, question_text="What part of the apple tree produces fruit?",),
            Quiz(plant_id=1, question_text="Which of these is a popular variety of apple?",),
            Quiz(plant_id=1, question_text="Where do apple trees thrive the best?",),
            Quiz(plant_id=1, question_text="What is the apple fruit's main benefit?",),
            Quiz(plant_id=1, question_text="How do you best store apples to maintain freshness?",),
            Quiz(plant_id=1, question_text="How many types of apple varieties exist around the world?",),
            Quiz(plant_id=1, question_text="What is the average lifespan of an apple tree?",),
            Quiz(plant_id=1, question_text="When do apple trees typically start bearing fruit?",),
        
            # Pertanyaan untuk tanaman Cherry
            Quiz(plant_id=2, question_text="What is the primary color of most cherry fruits?",),
            Quiz(plant_id=2, question_text="What is a significant health benefit of cherries?",),
            Quiz(plant_id=2, question_text="What is the shape of most cherry fruits?",),
            Quiz(plant_id=2, question_text="Which type of cherry is used for making cherry pies?",),
            Quiz(plant_id=2, question_text="Which climate is ideal for growing cherry trees?",),
            Quiz(plant_id=2, question_text="How long does it typically take for a cherry tree to bear fruit?",),
            Quiz(plant_id=2, question_text="What is the best way to preserve cherries for long-term storage?",),
            Quiz(plant_id=2, question_text="What is the major difference between sweet and sour cherries?",),
            Quiz(plant_id=2, question_text="What is the average lifespan of a cherry tree?",),
            Quiz(plant_id=2, question_text="Where are cherry trees most commonly grown?",),

            # Pertanyaan untuk tanaman Grape
            Quiz(plant_id=3, question_text="What is the primary color of ripe grape fruits?",),
            Quiz(plant_id=3, question_text="What is the main use of grape in food production?",),
            Quiz(plant_id=3, question_text="Which climate is most suitable for growing grapes?",),
            Quiz(plant_id=3, question_text="What type of plant structure does grape grow on?",),
            Quiz(plant_id=3, question_text="How many hours of sunlight do grapevines require daily?",),
            Quiz(plant_id=3, question_text="What is the scientific name of grape?",),
            Quiz(plant_id=3, question_text="What is the common pest that affects grapevines?",),
            Quiz(plant_id=3, question_text="In which season are grapes typically harvested?",),
            Quiz(plant_id=3, question_text="What is the average water requirement for grapevines per week?",),
            Quiz(plant_id=3, question_text="Which region is the largest producer of grapes worldwide?",),

            # Pertanyaan untuk tanaman Srawberry
            Quiz(plant_id=4, question_text="What is the primary color of ripe strawberries?",),
            Quiz(plant_id=4, question_text="What type of soil is best for growing strawberries?",),
            Quiz(plant_id=4, question_text="How often should strawberries be watered during growing season?",),
            Quiz(plant_id=4, question_text="What is the common pest that affects strawberry plants?",),
            Quiz(plant_id=4, question_text="What is the scientific name of strawberry?",),
            Quiz(plant_id=4, question_text="Which climate is most suitable for growing strawberries?",),
            Quiz(plant_id=4, question_text="What is the typical lifespan of a strawberry plant?",),
            Quiz(plant_id=4, question_text="Which season is the peak harvest time for strawberries?",),
            Quiz(plant_id=4, question_text="How much sunlight do strawberries require daily?",),
            Quiz(plant_id=4, question_text="Which vitamin is abundant in strawberries?",),            

            # Pertanyaan untuk tanaman Tomato
            Quiz(plant_id=5, question_text="What is the primary color of ripe tomatoes?",),
            Quiz(plant_id=5, question_text="What type of plant is tomato?",),
            Quiz(plant_id=5, question_text="What is the scientific name of tomato?",),
            Quiz(plant_id=5, question_text="Which climate is most suitable for growing tomatoes?",),
            Quiz(plant_id=5, question_text="What is the common pest that affects tomato plants?",),
            Quiz(plant_id=5, question_text="How much water do tomato plants require weekly?",),
            Quiz(plant_id=5, question_text="What is the best soil type for tomatoes?",),
            Quiz(plant_id=5, question_text="In which season are tomatoes typically harvested?",),
            Quiz(plant_id=5, question_text="How many hours of sunlight do tomatoes need daily?",),
            Quiz(plant_id=5, question_text="Which nutrient is most abundant in tomatoes?",),
        ]
        db.add_all(quizzes)
        db.commit() # Catat Perubahan

