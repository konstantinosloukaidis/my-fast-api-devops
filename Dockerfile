# Use a slim base image
FROM python:3.11-slim

# Set environment variables
# ENV PYTHONDONTWRITEBYTECODE=1
# ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y python3 python3-pip && apt-get clean && rm -rf /var/lib/apt/lists/* && \
	pip install --upgrade pip && \
	pip install fastapi uvicorn

# Copy project files
COPY fastapiproj.py /app/fastapiproj.py

# Run the FastAPI app with uvicorn
CMD ["uvicorn", "fastapiproj:app", "--host", "0.0.0.0", "--port", "8000"]
