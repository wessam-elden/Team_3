from ultralytics import YOLO

data_path = r"C:\Users\Tech\Desktop\Egypt\data.yaml"

model = YOLO("yolov8n.pt")

# تدريب الموديل
model.train(
    data=data_path,
    epochs=40,
    imgsz=416,
    project="EGYPTO0",
    augment=True,  
    hsv_h=0.1,    
)
