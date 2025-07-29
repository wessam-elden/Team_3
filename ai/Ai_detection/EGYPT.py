import cv2
import json
import numpy as np
from ultralytics import YOLO
from datetime import datetime

# Load the model
model = YOLO(r".\EGYPTO0\weights\best.pt")

# Load landmark descriptions
with open(r".\dis.json", "r", encoding="utf-8") as f:
    landmark_info = json.load(f)

# Open the camera
cam = cv2.VideoCapture(0)
if not cam.isOpened():
    exit()


conf_threshold = 0.65
iou_threshold = 0.45
last_detected_name = ""
freeze = False
frozen_frame = None

try:
    while True:
        ret, frame = cam.read()
        if not ret:
            print("Error reading frame")
            break

        key = cv2.waitKey(1) & 0xFF

        if not freeze:
            display_frame = frame.copy()
            cv2.putText(display_frame, "", (10, 30),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 255, 255), 2)
            cv2.imshow("Camera", display_frame)

        if key == 32:  # Space
            freeze = True
            frozen_frame = frame.copy()
            processed = cv2.convertScaleAbs(frozen_frame, alpha=1.2, beta=20)

            results = model(processed, iou=iou_threshold, conf=conf_threshold, verbose=False)[0]
            detected = False

            for box in results.boxes:
                conf = float(box.conf[0])
                if conf < conf_threshold:
                    continue

                cls_id = int(box.cls[0])
                name = model.names[cls_id].strip()

                # x1, y1, x2, y2 = map(int, box.xyxy[0])
                # label = f"{name} ({conf:.0%})"

                # Draw bounding box and label
                # cv2.rectangle(processed, (x1, y1), (x2, y2), (0, 255, 0), 2)
                # cv2.putText(processed, label, (x1, y1 - 10),
                #             cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 255, 0), 2)

                # Show description
                description = landmark_info.get(name, "")
                y_text = 30
                desc_lines = [description[i:i+70] for i in range(0, len(description), 70)]
                rect_height = 40 + len(desc_lines) * 25
                
                cv2.rectangle(processed, (0, 0), (processed.shape[1], rect_height), (255, 255, 255), -1)

                cv2.putText(processed, f"This is a : {name}", (10, y_text),
                            cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 150), 2)
                y_text += 30

                for i in range(0, len(description), 70):
                    line = description[i:i + 70]
                    cv2.putText(processed, line, (10, y_text),
                                cv2.FONT_HERSHEY_SIMPLEX, 0.6, (50, 50, 50), 1)
                    y_text += 25

                last_detected_name = name
                detected = True
                break  # Only first detected landmark

            if not detected:
                last_detected_name = ""
                cv2.rectangle(processed, (0, 0), (processed.shape[1], 50), (255, 255, 255), -1)
                cv2.putText(processed, "No landmark detected.", (10, 30),
                            cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)

            cv2.imshow("Result", processed)

        elif key == ord('s') and freeze and last_detected_name:
            filename = f"snapshot_{datetime.now().strftime('%Y%m%d_%H%M%S')}_{last_detected_name}.jpg"
            cv2.imwrite(filename, frozen_frame)
            print(f"Saved: {filename}")

        elif key == 27:  # ESC
            break

        elif key != 255:
            freeze = False
            try:
                cv2.destroyWindow("Result")
            except:
                pass

finally:
    cam.release()
    cv2.destroyAllWindows()
