# Use a lightweight Python image
FROM python:3.9-slim

# Set the working directory
WORKDIR /assignment

# Prevent Python from buffering logs (important for CI)
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Copy only the requirements first to leverage Docker caching
COPY requirements.txt .

# Install the pinned dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the app and test folders into the container
COPY . .

# Run the test suite by default in verbose mode
CMD ["pytest", "-v"]