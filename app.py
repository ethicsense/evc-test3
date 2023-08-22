import gradio as gr
import os
import cv2
from ultralytics import YOLO


model = YOLO('yolov8n.pt')
a = os.path.join(os.path.dirname(__file__), "video/test.mp4")  # Test Video


def video_demo(video):

    cap = cv2.VideoCapture(video)
    width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
    fourcc = cv2.VideoWriter_fourcc(*'avc1')
    out = cv2.VideoWriter(
        os.path.join(os.path.dirname(__file__),'video/out/output.mp4'),
        fourcc,
        30.0,
        (width,height)
    )
    output_file = os.path.join(os.path.dirname(__file__),'video/out/output.mp4')

    while cap.isOpened():
    # Read a frame from the video
        success, frame = cap.read()

        if success:
            # Run YOLOv8 inference on the frame
            results = model(frame)

            # Visualize the results on the frame
            annotated_frame = results[0].plot()

            # # write video
            out.write(annotated_frame)

            # Break the loop if 'q' is pressed
            if cv2.waitKey(1) & 0xFF == ord("q"):
                break
        else:
            # Break the loop if the end of the video is reached
            break
    
    cap.release()
    out.release()

    return output_file


demo = gr.Interface(
    fn=video_demo,
    inputs=gr.Video(),
    outputs=gr.Video(),
    examples=[
        a
    ]
)

if __name__ == "__main__":
    
    demo.launch(
        server_name='0.0.0.0',
        server_port=7860
    )