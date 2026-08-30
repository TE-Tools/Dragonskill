import cv2
import os
video_path = r'C:/Users/thoma/StudioProjects/Dragonskill/Aufzeichnung 2026-08-30 164121.mp4'
output_dir = r'C:/Users/thoma/StudioProjects/Dragonskill/frames_waechter'
if not os.path.exists(output_dir): os.makedirs(output_dir)
cap = cv2.VideoCapture(video_path)
for f in range(0, 300, 20):
    cap.set(cv2.CAP_PROP_POS_FRAMES, f)
    ret, frame = cap.read()
    if ret: cv2.imwrite(os.path.join(output_dir, f'frame_{f}.jpg'), frame)
cap.release()
