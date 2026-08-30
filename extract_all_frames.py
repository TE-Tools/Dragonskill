import cv2
import os

video_path = r'C:/Users/thoma/StudioProjects/Dragonskill/Aufzeichnung 2026-08-30 164121.mp4'
output_dir = r'C:/Users/thoma/StudioProjects/Dragonskill/frames_all'

if not os.path.exists(output_dir):
    os.makedirs(output_dir)

cap = cv2.VideoCapture(video_path)
total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))

# Extrahiere Frames, um alle Tabs zu erwischen.
# 100 Frames bei 60 fps sind ca. 1.6 Sekunden.
for f in range(0, total_frames, 100):
    cap.set(cv2.CAP_PROP_POS_FRAMES, f)
    ret, frame = cap.read()
    if ret:
        cv2.imwrite(os.path.join(output_dir, f'frame_{f}.jpg'), frame)
cap.release()
print(f"Extracted frames to {output_dir}")
