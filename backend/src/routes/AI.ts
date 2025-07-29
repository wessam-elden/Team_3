// routes/auth.ts
import { Router } from 'express';
import { verifyTokenMiddleware } from '../middlewares/auth';
import { handleChat , detectHandler } from '../modules/AI';
import multer from 'multer';

const router = Router();


router.post('/chat' , verifyTokenMiddleware, handleChat);

const upload = multer({ dest: 'uploads/' });

router.post('/detect', upload.single('image'),verifyTokenMiddleware, detectHandler);

export default router;
