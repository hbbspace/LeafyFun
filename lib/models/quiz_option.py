from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from sqlalchemy.orm import relationship
from lib.services.database import Base
from sqlalchemy.orm import Session

class QuizOption(Base):
    __tablename__ = "quiz_options"
    
    option_id = Column(Integer, primary_key=True, index=True)
    quiz_id = Column(Integer, ForeignKey("quizzes.quiz_id"))
    option_text = Column(String(255))
    is_correct = Column(Boolean)

    quiz = relationship("Quiz", back_populates="quiz_options")

def quiz_option_init(db: Session):
    if db.query(QuizOption).count() == 0:
        # Pertanyaan untuk tanaman Apple
        quiz_options = [
            QuizOption(quiz_id=1, option_text="Red", is_correct=True),
            QuizOption(quiz_id=1, option_text="Yellow", is_correct=False),
            QuizOption(quiz_id=1, option_text="Green", is_correct=False),
            QuizOption(quiz_id=1, option_text="Purple", is_correct=False),
                    
            QuizOption(quiz_id=2, option_text="Vitamin A", is_correct=False),
            QuizOption(quiz_id=2, option_text="Vitamin C", is_correct=True),
            QuizOption(quiz_id=2, option_text="Vitamin D", is_correct=False),
            QuizOption(quiz_id=2, option_text="Vitamin B12", is_correct=False),
                    
            QuizOption(quiz_id=3, option_text="Leaves", is_correct=False),
            QuizOption(quiz_id=3, option_text="Roots", is_correct=False),
            QuizOption(quiz_id=3, option_text="Flowers", is_correct=True),
            QuizOption(quiz_id=3, option_text="Bark", is_correct=False),
                    
            QuizOption(quiz_id=4, option_text="Gala", is_correct=True),
            QuizOption(quiz_id=4, option_text="Rose", is_correct=False),
            QuizOption(quiz_id=4, option_text="Tulip", is_correct=False),
            QuizOption(quiz_id=4, option_text="Daisy", is_correct=False),
                    
            QuizOption(quiz_id=5, option_text="Tropical climates", is_correct=False),
            QuizOption(quiz_id=5, option_text="Temperate regions", is_correct=True),
            QuizOption(quiz_id=5, option_text="Desert climates", is_correct=False),
            QuizOption(quiz_id=5, option_text="Arctic regions", is_correct=False),
                    
            QuizOption(quiz_id=6, option_text="Rich in protein", is_correct=False),
            QuizOption(quiz_id=6, option_text="High in fiber", is_correct=True),
            QuizOption(quiz_id=6, option_text="Low in calories", is_correct=False),
            QuizOption(quiz_id=6, option_text="Contains caffeine", is_correct=False),
                    
            QuizOption(quiz_id=7, option_text="In the freezer", is_correct=False),
            QuizOption(quiz_id=7, option_text="In a cool, dry place", is_correct=True),
            QuizOption(quiz_id=7, option_text="In direct sunlight", is_correct=False),
            QuizOption(quiz_id=7, option_text="Under water", is_correct=False),
                    
            QuizOption(quiz_id=8, option_text="100-200", is_correct=False),
            QuizOption(quiz_id=8, option_text="200-300", is_correct=True),
            QuizOption(quiz_id=8, option_text="500-600", is_correct=False),
            QuizOption(quiz_id=8, option_text="1000+", is_correct=False),
                    
            QuizOption(quiz_id=9, option_text="10-15 years", is_correct=False),
            QuizOption(quiz_id=9, option_text="30-50 years", is_correct=True),
            QuizOption(quiz_id=9, option_text="5-10 years", is_correct=False),
            QuizOption(quiz_id=9, option_text="100 years", is_correct=False),
                    
            QuizOption(quiz_id=10, option_text="After 1 year", is_correct=False),
            QuizOption(quiz_id=10, option_text="After 3-4 years", is_correct=True),
            QuizOption(quiz_id=10, option_text="After 10 years", is_correct=False),
            QuizOption(quiz_id=10, option_text="After 20 years", is_correct=False),
                    
                    
                    # Pertanyaan untuk tanaman Cherry
            QuizOption(quiz_id=11, option_text="Yellow", is_correct=False),
            QuizOption(quiz_id=11, option_text="Red", is_correct=True),
            QuizOption(quiz_id=11, option_text="Green", is_correct=False),
            QuizOption(quiz_id=11, option_text="Blue", is_correct=False),
                    
            QuizOption(quiz_id=12, option_text="Rich in antioxidants", is_correct=True),
            QuizOption(quiz_id=12, option_text="High in caffeine", is_correct=False),
            QuizOption(quiz_id=12, option_text="Low in vitamin C", is_correct=False),
            QuizOption(quiz_id=12, option_text="High in fats", is_correct=False),
                    
            QuizOption(quiz_id=13, option_text="Oval", is_correct=False),
            QuizOption(quiz_id=13, option_text="Round", is_correct=True),
            QuizOption(quiz_id=13, option_text="Long", is_correct=False),
            QuizOption(quiz_id=13, option_text="Flat", is_correct=False),
                    
            QuizOption(quiz_id=14, option_text="Sour cherries", is_correct=True),
            QuizOption(quiz_id=14, option_text="Sweet cherries", is_correct=False),
            QuizOption(quiz_id=14, option_text="Wild cherries", is_correct=False),
            QuizOption(quiz_id=14, option_text="Tart cherries", is_correct=False),
                    
            QuizOption(quiz_id=15, option_text="Tropical climates", is_correct=False),
            QuizOption(quiz_id=15, option_text="Temperate climates", is_correct=True),
            QuizOption(quiz_id=15, option_text="Desert climates", is_correct=False),
            QuizOption(quiz_id=15, option_text="Arctic climates", is_correct=False),
                    
            QuizOption(quiz_id=16, option_text="1-2 years", is_correct=False),
            QuizOption(quiz_id=16, option_text="3-5 years", is_correct=True),
            QuizOption(quiz_id=16, option_text="7-10 years", is_correct=False),
            QuizOption(quiz_id=16, option_text="20+ years", is_correct=False),
                    
            QuizOption(quiz_id=17, option_text="Freezing", is_correct=True),
            QuizOption(quiz_id=17, option_text="Drying", is_correct=False),
            QuizOption(quiz_id=17, option_text="Pickling", is_correct=False),
            QuizOption(quiz_id=17, option_text="Baking", is_correct=False),
                    
            QuizOption(quiz_id=18, option_text="Sweet cherries are larger", is_correct=False),
            QuizOption(quiz_id=18, option_text="Sour cherries are typically used for pies", is_correct=True),
            QuizOption(quiz_id=18, option_text="Sweet cherries have a thicker skin", is_correct=False),
            QuizOption(quiz_id=18, option_text="Sour cherries are sweeter", is_correct=False),
                    
            QuizOption(quiz_id=19, option_text="10-15 years", is_correct=False),
            QuizOption(quiz_id=19, option_text="15-20 years", is_correct=True),
            QuizOption(quiz_id=19, option_text="20-30 years", is_correct=False),
            QuizOption(quiz_id=19, option_text="50 years", is_correct=False),
                    
            QuizOption(quiz_id=20, option_text="Europe and North America", is_correct=True),
            QuizOption(quiz_id=20, option_text="Asia and South America", is_correct=False),
            QuizOption(quiz_id=20, option_text="Africa and Australia", is_correct=False),
            QuizOption(quiz_id=20, option_text="South Pacific Islands", is_correct=False),
                ]
            
        db.add_all(quiz_options)
        db.commit() # Catat Perubahan