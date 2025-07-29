# 🗺 Maporia

Maporia is a smart mobile application focused on domestic tourism in Egypt. It helps users explore Egyptian governorates, discover historical and cultural attractions, and interact with intelligent tools such as an AI chatbot and a landmark scanner.

---

## 📋 Table of Contents

- [Project Overview](#-maporia)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Backend Setup](#backend-setup-expressjs--mysql)
- [AI Chatbot](#-ai-chatbot-integration-langchain--faiss--huggingface)
- [Landmark Detection API](#-landmark-detection-api-yolov8--flask)
- [Key Features](#key-features)
- [Troubleshooting](#troubleshooting)
- [Contact](#contact)

---

## Prerequisites

- A computer running Windows or macOS
- An Android mobile device (Developer Mode must be enabled)
- Android Studio installed and configured
- Flutter SDK installed (for fetching dependencies and running the app)

---

## Setup Instructions

### 1. Install All Dependencies

After cloning or downloading the project, open a terminal in the project directory and run:

bash
flutter pub get


---

### 2. Run the App on an Android Device

- Enable Developer Mode on your Android phone.
- Enable USB Debugging under Developer Options.
- Connect your Android device to your computer via USB.
- Open Android Studio, or run:

bash
flutter run


---

## Backend Setup (Express.js + MySQL)

### 1. Prerequisites

- Node.js (v18 or higher)
- MySQL Server & MySQL Workbench
- Postman (for API testing)

---

### 2. Installation

Clone the backend folder and navigate to it:

bash
cd backend
npm install


Create a .env file with the following:

env
PORT=4040
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=
DB_NAME=mydb

# JWT secret key
JWT_SECRET=super_secret_key_123

---

### 3. Running the Backend

bash
npm run dev

npm run seed    =>   to full database
npx tsc     => to make build folder


API available at:  
http://localhost:4040

---
All APIs need token in header except login , signup 
### 4. API Highlights

- POST /auth/signup – Create a new user  
- POST /auth/login – Login and receive JWT  
- POST /visit/create – Create a visit (auth required)  
- GET /city/all – List all cities  
- GET /visit/all – List all visits  
- GET /auth/profile – Get profile of user  
- GET /landmarks/:id – Get landmarks for a specific city  
- GET /landmark/all – List all landmarkes  
- POST /landmark/create – Add a new landmark (admin only)  
- POST /city/create – Add a new city (admin only)  
-post http://localhost:4040/AI/detect
-post http://localhost:4040/AI/chat


Method: POST
URL: http://localhost:4040/auth/signup

Headers:
Content-Type: application/json

Body (raw JSON):
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "123456"
}

Success Response:
Status: 201 Created
{
  "message": "User registered successfully"
}

Error:
Status: 400 Bad Request (if email already used or missing fields)
✅ 2. POST /auth/login – Login and receive JWT
makefile
Copy
Edit
Method: POST
URL: http://localhost:4040/auth/login

Headers:
Content-Type: application/json

Body (raw JSON):
{
  "email": "john@example.com",
  "password": "123456"
}

Success Response:
Status: 200 OK
{
  "token": "<JWT_TOKEN>"
}

Error:
Status: 401 Unauthorized (if credentials are invalid)
✅ 3. POST /visit/create – Create a visit (requires auth)
makefile
Copy
Edit
Method: POST
URL: http://localhost:4040/visit/create

Headers:
Content-Type: application/json
Authorization: Bearer <JWT_TOKEN>

Body (raw JSON):
{
  "idUser": 1,
  "idcities": 2,
  "idlandmarkes": 3,
  "visit_date": "2025-07-29"
}

Success Response:
Status: 201 Created
{
  "message": "Visit created successfully"
}

Error:
401 Unauthorized (missing or invalid token)
✅ 4. GET /city/all – List all cities
makefile
Copy
Edit
Method: GET
URL: http://localhost:4040/city/all

No headers or auth required.

Success Response:
Status: 200 OK
[
  {
    "idcities": 1,
    "name": "Cairo"
  },
  {
    "idcities": 2,
    "name": "Luxor"
  }
]
✅ 5. GET /visit/all – List all visits
yaml
Copy
Edit
Method: GET
URL: http://localhost:4040/visit/all

No headers or auth required.

Success Response:
Status: 200 OK
[
  {
    "idUser": 1,
    "idcities": 2,
    "idlandmarkes": 3,
    "visit_date": "2025-07-29"
  }
]
✅ 6. GET /auth/profile – Get current user's profile
makefile
Copy
Edit
Method: GET
URL: http://localhost:4040/auth/profile

Headers:
Authorization: Bearer <JWT_TOKEN>

Success Response:
Status: 200 OK
{
  "idUser": 1,
  "name": "John Doe",
  "email": "john@example.com",
  "role": "user"
}

Error:
401 Unauthorized (missing or invalid token)
✅ 7. GET /landmarks/:id – Get landmarks for a specific city
makefile
Copy
Edit
Method: GET
URL: http://localhost:4040/landmarks/1

No headers or auth required.

Success Response:
Status: 200 OK
[
  {
    "idlandmarkes": 1,
    "name": "Pyramids",
    "description": "Famous pyramids of Giza"
  }
]
✅ 8. GET /landmark/all – List all landmarks
makefile
Copy
Edit
Method: GET
URL: http://localhost:4040/landmark/all

No headers or auth required.

Success Response:
Status: 200 OK
[
  {
    "idlandmarkes": 1,
    "name": "Pyramids",
    "description": "Famous pyramids"
  }
]
✅ 9. POST /landmark/create – Add a new landmark (admin only)
makefile
Copy
Edit
Method: POST
URL: http://localhost:4040/landmark/create

Headers:
Content-Type: application/json
Authorization: Bearer <ADMIN_JWT_TOKEN>

Body (raw JSON):
{
  "name": "Abu Simbel",
  "description": "Ancient temple",
  "idcities": 2
}

Success Response:
Status: 201 Created
{
  "message": "Landmark created successfully"
}

Error:
403 Forbidden (if not admin)
✅ 10. POST /city/create – Add a new city (admin only)
makefile
Copy
Edit
Method: POST
URL: http://localhost:4040/city/create

Headers:
Content-Type: application/json
Authorization: Bearer <ADMIN_JWT_TOKEN>

Body (raw JSON):
{
  "name": "Aswan"
}

Success Response:
Status: 201 Created
{
  "message": "City created successfully"
}

Error:
403 Forbidden (if not admin)
✅ 11. POST /AI/detect – Upload image to detect landmark
makefile
Copy
Edit
Method: POST
URL: http://localhost:4040/AI/detect

Headers:
Content-Type: multipart/form-data

Body (form-data):
Key: image   | Type: File   | Value: Choose image file

Success Response:
Status: 200 OK
{
  "name": "Pyramids",
  "description": "Ancient Egyptian pyramids",
  "image": "<base64-encoded annotated image>"
}

Error:
400 Bad Request (if image is missing)
✅ 12. POST /AI/chat – Ask question about landmarks
makefile
Copy
Edit
Method: POST
URL: http://localhost:4040/AI/chat

Headers:
Content-Type: application/json

Body (raw JSON):
{
  "question": "Where are the pyramids located?"
}

Success Response:
Status: 200 OK
{
  "answer": "The pyramids are located in Giza, Egypt."
}

Error:
400 Bad Request (if question is missing)
---

## 🤖 AI Chatbot Integration (LangChain + FAISS + HuggingFace)

This component answers user questions about Egyptian tourism using local LLMs and a FAISS vector store.

### 🧠 Features

- Answer natural language questions about Egypt's historical sites
- Uses LangChain’s RetrievalQA for contextual understanding
- Vector-based retrieval using FAISS and sentence embeddings
- Offline-capable: Runs locally with HuggingFace LLM (flan-alpaca-base)
- Automatically indexes and searches Q&A datasets and city/place recommendations
- Fast response time with minimal resource usage
- Embeddings with sentence-transformers/all-mpnet-base-v2
- Local LLM (flan-alpaca-base)
- Powered by Flask

---

### API Endpoints

- GET / – Health check
- POST /chat – Submit questions to the AI

### Example Request

json
POST /chat
{
  "question": "What are the best places to visit in Aswan?"
}


### Example Response

json
{
  "answer": "Some top places in Aswan include Philae Temple, the Unfinished Obelisk, and the Nubian Museum.",
  "response_time_sec": 1.23
}


---

### How to Run the Chatbot

1. Ensure egypt_historical_places.json and egypt_tourism_and_historical_sites.json exist in the same folder.
2. Run:

bash
python chatbot_server.py


App runs at:  
http://localhost:1234

---

## 📸 Landmark Detection API (YOLOv8 + Flask)

This module detects Egyptian landmarks in photos using a trained YOLOv8 model and returns details about the site.

### Endpoint

- POST /detect – Accepts multipart/form-data image upload

### Request

bash
curl -X POST http://127.0.0.1:5000/detect \
  -F image=@path_to_image.jpg


### Example Response

json
{
  "landmark": "Karnak_Temple",
  "description": "The Karnak Temple Complex is a vast mix of decayed temples near Luxor.",
  "image": "base64_encoded_image_string"
}


---

### How to Run the Detector

1. Place the YOLOv8 model (best.pt) and metadata (dis.json) correctly.
2. Install dependencies:

bash
pip install flask opencv-python numpy ultralytics


3. Run:

bash
python detection_server.py


Server runs at:  
http://127.0.0.1:5000/detect

---

## Key Features

- Explore attractions by governorate  
- Landmark details with photos and descriptions  
- Save favorite attractions  
- Mark visited places  
- AI-powered chatbot assistant  
- Camera-based landmark scanning  
- Secure backend with JWT authentication  
- Admin & user roles for managing content

---

## Troubleshooting

### Mobile App

- *Device not detected*: Ensure Developer Mode and USB Debugging are enabled.
- *Flutter errors*: Run flutter doctor to diagnose environment issues.

### Backend

- *MySQL issues*: Ensure credentials in .env are correct and MySQL is running.
- *CORS errors*: Check CORS middleware in Express.

### AI Services

- *Chatbot slow or fails*: Ensure the LLM and FAISS index are properly loaded.
- *Landmark detection fails*: Make sure best.pt is valid and confidence threshold is tuned.

---

## Contact

For support or questions:  
*Wessam* – [wessamelden7@gmail.com]

---