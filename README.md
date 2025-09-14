# Cat Emotion Recognition and Chatbot App

This project is a multimodal mobile application that integrates computer vision and natural language processing to help cat owners identify their pets’ emotions and receive personalized care suggestions.

## Features

- **Emotion Recognition**
  - Detects cat emotions: Angry, Fear, Interest, Joy, Neutral using YOLO models.
  - Dataset includes 2,820 annotated images with data augmentation (brightness adjustment, blur, noise).

- **Chatbot Assistant**
  - Built with LLaMA 3.2 3B plus Retrieval-Augmented Generation (RAG).
  - Knowledge base comprises 592 curated Q&A pairs from veterinary and animal care sources.

- **App Functionality**
  - User registration & login via OAuth.
  - Daily data logging, visualization charts.
  - Interaction via image upload or text input.

## Tech Stack

- Frontend: Flutter  
- Backend: Express.js  
- Database: SQLite  
- AI Models: YOLOv5-YOLOv11 (comparison), LLaMA 3.2 3B + RAG  
- Authentication: OAuth  

## Model Performance

| Model    | mAP@0.5 | Precision | Recall | Accuracy |
|----------|---------|-----------|--------|----------|
| YOLOv9m  | 84.7%   | 83.0%     | 82.0%  | 84.0%    |
| YOLOv8m  | 83.5%   | 85.1%     | 76.8%  | 80.9%    |
| YOLOv11s | 84.3%   | 78.2%     | 79.1%  | 81.5%    |

**LLM + RAG vs. LLM alone**  
- Accuracy: 3.25 → 4.60  
- Factual consistency: 2.88 → 4.68  
- SBERT similarity: 74.2% → 84.5%

## Installation

```bash
git clone https://github.com/LucyHsieh1013/Pet_Diary_App.git
cd Pet_Diary_App
```

## Publications

- Accepted at **TANET 2025**  
- Supported by **MOST Undergraduate Research Project**
