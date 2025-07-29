import { Request, Response } from 'express';
import { sendChatMessage,detectLandmark } from '../utilites/AI'; // wherever your function is

import  File from 'multer';
import xss from 'xss';




export async function handleChat(req: Request, res: Response) {
  try {
    let { question } = req.body;

    // validate input
    if (!question || typeof question !== 'string') {
      return res.status(400).json({ message: 'Invalid question' });
    }

    // ✅ Sanitize question to prevent XSS
    question = xss(question);

    const response = await sendChatMessage({ question });

    return res.status(200).json(response);
  } catch (error: any) {
    console.error('Chat handler error:', error.message);
    return res.status(500).json({ message: 'Internal Server Error' });
  }
}



interface MulterRequest extends Request {
  file?: Express.Multer.File;
}

export async function detectHandler(req: MulterRequest, res: Response) {
  try {
    const imagePath = req.file?.path;

    if (!imagePath) {
      return res.status(400).json({ error: 'Image file is required' });
    }

    const result = await detectLandmark(imagePath);

    res.json(result);
  } catch (error: any) {
    res.status(500).json({ error: error.message });
  }
}
