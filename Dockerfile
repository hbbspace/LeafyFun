# Menggunakan Python versi 3.12.4 sebagai image dasar
FROM python:3.12.4

# Set work directory dalam container
WORKDIR /app

# Salin file requirements.txt ke container dan install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Salin semua kode proyek ke dalam container
COPY . .

# Expose port yang akan digunakan oleh FastAPI
EXPOSE 8000

# Perintah untuk menjalankan aplikasi
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]