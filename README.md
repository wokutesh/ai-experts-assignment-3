# AI Experts Assignment 3

This project consists of an application and a test suite designed to run in a clean, CI-style environment.

## Prerequisites
* Python 3.9+
* Docker Desktop (for containerized testing)

## How to Run Tests Locally

Follow these steps to set up your environment and run the test suite on your local machine:

### 1. Set up a Virtual Environment (Optional but Recommended)
Create and activate a virtual environment to keep your dependencies isolated:
```bash
# Create the environment
python -m venv venv

# Activate it (Windows)
.\venv\Scripts\activate

# Activate it (macOS/Linux)
source venv/bin/activate

### 2. Install Dependencies
Use `pip` to install the specific versions of the libraries required for this project:
```bash

pip install -r requirements.txt

pytest -v


## How to Build and Run Tests with Docker

To ensure the tests run in a clean, non-interactive CI-style environment, use the following Docker commands:

### 1. Build the Docker Image
This command creates an image named `assignment-3-final` based on the instructions in the `Dockerfile`. It will install all pinned dependencies from `requirements.txt`.
```bash
docker build -t assignment-3-final .

docker run --rm assignment-3-final

