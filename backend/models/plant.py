from sqlalchemy import Column, Enum, Integer, String, Text
from backend.services.database import Base
from sqlalchemy.orm import Session

class Plant(Base):
    __tablename__ = "plants"
    
    plant_id = Column(Integer, primary_key=True, index=True)
    common_name = Column(String(100))
    latin_name = Column(String(100))
    description = Column(Text)
    fruit_content = Column(String(255))
    fruit_season = Column(String(50))
    region = Column(String(100))
    price_range = Column(String(50))
    image_file = Column(String(255))

def plant_init(db: Session):
    if db.query(Plant).count() == 0:
            plants = [
                Plant(
                    common_name="Apple",
                    latin_name="Malus domestica",
                    description="Apple trees produce sweet and juicy fruits that are widely consumed fresh or used in various dishes. They grow best in cooler highland climates and are commonly cultivated in temperate regions. Apples are rich in essential nutrients and antioxidants. Regular pruning and care are required for optimal fruit production.",
                    fruit_content="Vitamin C, Vitamin A, Vitamin K, Fiber, Potassium, Antioxidants",
                    fruit_season="Autumn",
                    region="Malang (East Java), Bandung (West Java), and other highland areas in Indonesia",
                    price_range="Rp150,000 - Rp500,000 per tree",
                    image_file="apple.jpg"
                ),

                Plant(
                    common_name="Cherry",
                    latin_name="Prunus avium",
                    description="Cherry trees are known for their sweet and tart fruits that are often eaten fresh or used in desserts. They prefer cooler climates and require well-drained soil. The blossoms are a popular attraction during spring. Cherries are rich in vitamins and antioxidants, making them a healthy choice.",
                    fruit_content="Vitamin C, Vitamin A, Fiber, Antioxidants",
                    fruit_season="Late spring to early summer",
                    region="Highland areas in Indonesia such as Malang and Bandung",
                    price_range="Rp300,000 - Rp700,000 per tree",
                    image_file="cherry.jpg"
                ),

                Plant(
                    common_name="Grape",
                    latin_name="Vitis vinifera",
                    description="Grapes are versatile fruits used for eating fresh, making wine, or as dried raisins. Grape vines grow well in warm climates with adequate sunlight. They require trellising for support and pruning for better fruit yield. Grapes are rich in vitamins and resveratrol, a powerful antioxidant.",
                    fruit_content="Vitamin C, Vitamin K, Potassium, Antioxidants",
                    fruit_season="Summer to early autumn",
                    region="Banyuwangi (East Java), Bali, and other warm regions in Indonesia",
                    price_range="Rp50,000 - Rp200,000 per vine",
                    image_file="grape.jpg"
                ),

                Plant(
                    common_name="Strawberry",
                    latin_name="Fragaria × ananassa",
                    description="Strawberry plants produce sweet and tangy red fruits that are highly popular worldwide. They thrive in cooler climates with well-drained, fertile soil. Strawberries are rich in vitamins and antioxidants, promoting good health. These plants are relatively small and often grown in highland areas.",
                    fruit_content="Vitamin C, Manganese, Folate, Antioxidants",
                    fruit_season="Spring to early summer",
                    region="Lembang (West Java), Batu (East Java), and other highland areas in Indonesia",
                    price_range="Rp30,000 - Rp150,000 per plant",
                    image_file="strawberry.jpg"
                ),

                Plant(
                    common_name="Tomato",
                    latin_name="Solanum lycopersicum",
                    description="Tomatoes are versatile fruits used in many culinary dishes for their sweet and tangy flavor. They grow well in various climates and are easy to cultivate. Tomatoes are rich in lycopene, vitamins, and other nutrients. They require moderate watering and sufficient sunlight.",
                    fruit_content="Vitamin C, Vitamin A, Potassium, Lycopene",
                    fruit_season="All year round",
                    region="Throughout Indonesia",
                    price_range="Rp10,000 - Rp50,000 per plant",
                    image_file="tomato.jpg"
                )
            ]
            db.add_all(plants)
            db.flush()  # Catat perubahan