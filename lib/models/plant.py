from sqlalchemy import Column, Enum, Integer, String, Text
from lib.services.database import Base
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
                ),

                Plant(
                    common_name="Guava",
                    latin_name="Psidium guajava",
                    description="Guava trees are tropical plants that produce sweet and fragrant fruits. They grow well in various soil types and require warm, sunny climates. Guavas are packed with vitamins and dietary fiber, supporting healthy digestion. They are a popular choice among tropical fruit lovers.",
                    fruit_content="Vitamin C, Vitamin A, Dietary Fiber, Antioxidants",
                    fruit_season="All year round",
                    region="Throughout Indonesia",
                    price_range="Rp50,000 - Rp200,000 per tree",
                    image_file="guava.jpg"
                ),

                Plant(
                    common_name="Mango",
                    latin_name="Mangifera indica",
                    description="Mango trees are large tropical plants producing sweet and juicy fruits. They grow best in warm, sunny regions with well-drained soil. Mangoes are a rich source of vitamins and minerals. These trees are a common sight in tropical countries like Indonesia.",
                    fruit_content="Vitamin C, Vitamin A, Vitamin E, Fiber, Antioxidants",
                    fruit_season="Summer",
                    region="Throughout Indonesia",
                    price_range="Rp100,000 - Rp500,000 per tree",
                    image_file="mango.jpg"
                ),

                Plant(
                    common_name="Lemon",
                    latin_name="Citrus limon",
                    description="Lemon trees produce tangy and aromatic fruits commonly used for cooking, beverages, and medicinal purposes. They thrive in warm climates and well-drained soil. Lemons are rich in vitamin C and other nutrients. The tree is small to medium-sized, often grown in home gardens.",
                    fruit_content="Vitamin C, Potassium, Antioxidants",
                    fruit_season="All year round",
                    region="Bali, Lombok, and other warm regions in Indonesia",
                    price_range="Rp50,000 - Rp200,000 per tree",
                    image_file="lemon.jpg"
                ),

                Plant(
                    common_name="Jackfruit",
                    latin_name="Artocarpus heterophyllus",
                    description="Jackfruit trees are large tropical plants producing the world's largest tree-borne fruit. The fruit has a sweet and distinctive flavor, often used in desserts or as a meat substitute. Jackfruits are high in vitamins and dietary fiber. The trees grow well in warm, humid climates.",
                    fruit_content="Vitamin C, Vitamin B6, Potassium, Fiber",
                    fruit_season="Summer",
                    region="Throughout Indonesia",
                    price_range="Rp200,000 - Rp600,000 per tree",
                    image_file="jackfruit.jpg"
                ),

                Plant(
                    common_name="Papaya",
                    latin_name="Carica papaya",
                    description="Papaya plants are fast-growing tropical trees producing sweet and juicy fruits. They grow best in warm climates with fertile, well-drained soil. Papayas are rich in vitamins and enzymes that aid digestion. The plants are relatively small and require minimal maintenance.",
                    fruit_content="Vitamin C, Vitamin A, Folate, Potassium",
                    fruit_season="All year round",
                    region="Throughout Indonesia",
                    price_range="Rp50,000 - Rp150,000 per tree",
                    image_file="papaya.jpg"
                )
            ]
            db.add_all(plants)
            db.flush()  # Catat perubahan