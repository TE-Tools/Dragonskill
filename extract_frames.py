import cv2
import os

video_path = r'C:/Users/thoma/StudioProjects/Dragonskill/Aufzeichnung 2026-08-30 164121.mp4'
output_dir = r'C:/Users/thoma/StudioProjects/Dragonskill/frames'

if not os.path.exists(output_dir):
    os.makedirs(output_dir)

cap = cv2.VideoCapture(video_path)
total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))

# Extrahiere alle 2 Sekunden (bei ca. 60 fps)
step = 120
for f in range(0, total_frames, step):
    cap.set(cv2.CAP_PROP_POS_FRAMES, f)
    ret, frame = cap.read()
    if ret:
        cv2.imwrite(os.path.join(output_dir, f'frame_{f}.jpg'), frame)
cap.release()
print(f"Extracted frames to {output_dir}")
