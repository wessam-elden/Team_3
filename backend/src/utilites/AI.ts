import fs from 'fs';
import path from 'path';
import FormData from 'form-data';
import fetch from 'node-fetch'; // make sure this is installed

interface ChatRequest {
  question: string;
}

interface ChatResponse {
  answer: string;
  response_time_sec: number;
}

export async function sendChatMessage(data: ChatRequest): Promise<ChatResponse> {
  try {
    const res = await fetch('http://127.0.0.1:1234/chat', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    });

    const resJson: unknown = await res.json();

    if (!res.ok) {
      const errMessage = (resJson as any)?.message || 'Chat request failed';
      throw new Error(errMessage);
    }

    // Optional: validate structure
    if (
      typeof resJson !== 'object' ||
      resJson === null ||
      !('answer' in resJson) ||
      !('response_time_sec' in resJson)
    ) {
      throw new Error('Invalid response format from API');
    }

    return resJson as ChatResponse;
  } catch (error: any) {
    console.error('Chat API Error:', error.message);
    throw error;
  }
}


export async function detectLandmark(imagePath: string) {
  const form = new FormData();
  form.append('image', fs.createReadStream(imagePath));

  try {
    const response = await fetch('http://127.0.0.1:5000/detect', {
      method: 'POST',
      body: form as any, // fix TypeScript complaint
      headers: form.getHeaders(), // needed for multipart form
    });

    if (!response.ok) {
      throw new Error(`Flask service error: ${response.statusText}`);
    }

    const data = await response.json();
    return data; // { landmark, description, image }
  } catch (err) {
    console.error('Detection error:', err);
    throw err;
  }
}


