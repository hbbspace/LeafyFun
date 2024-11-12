# Menggunakan image Python sebagai base
FROM python:3.10

# Menetapkan direktori kerja
WORKDIR /app

# Menyalin requirements dan menginstal dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Menyalin semua file proyek ke container
COPY . .

# Mengekspose port untuk FastAPI
EXPOSE 8000

# Menjalankan aplikasi dengan Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
