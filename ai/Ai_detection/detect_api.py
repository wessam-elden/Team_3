import cv2
import json
import base64
import numpy as np
from flask import Flask, request, jsonify
from ultralytics import YOLO

app = Flask(__name__)

model = YOLO(r"c:\Users\Tech\Desktop\Egypt\EGYPTO0\weights\best.pt")
with open(r"c:\Users\Tech\Desktop\Egypt\dis.json", "r", encoding="utf-8") as f:
    landmark_info = json.load(f)

@app.route('/detect', methods=['POST'])
def detect():
    
    if 'image' not in request.files:
        return jsonify({'error': 'No image uploaded'}), 400
    file = request.files['image']
    npimg = np.frombuffer(file.read(), np.uint8)
    img = cv2.imdecode(npimg, cv2.IMREAD_COLOR)

    processed = cv2.convertScaleAbs(img, alpha=1.2, beta=20)

    results = model(processed, iou=0.45, conf=0.65, verbose=False)[0]
   
    for box in results.boxes:
        conf = float(box.conf[0])
        if conf < 0.65: continue

        cls_id = int(box.cls[0])
        name = model.names[cls_id].strip()

        # x1, y1, x2, y2 = map(int, box.xyxy[0])
        # cv2.rectangle(processed, (x1, y1), (x2, y2), (0, 255, 0), 2)
        # cv2.putText(processed, f"{name} ({conf:.0%})", (x1, y1 - 10),
        #             cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 255, 0), 2)

        description = landmark_info.get(name, "")

        _, buffer = cv2.imencode('.jpg', processed)
        img_base64 = base64.b64encode(buffer).decode('utf-8')

        return jsonify({
            'landmark': name,
            'description': description,
            'image': img_base64
        })

    # لو مفيش كشف
    return jsonify({'landmark': None, 'description': 'No landmark detected.'}), 200

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000)

