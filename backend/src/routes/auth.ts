// routes/auth.ts
import { Router } from 'express';
import { getProfile, login, signup } from '../modules/auth';
import { verifyTokenMiddleware } from '../middlewares/auth';
import { createVisitHandler, getAllVisitsHandler } from '../modules/visit';

const router = Router();

router.post('/signup', signup);

router.post('/login', login); 



router.get("/profile", verifyTokenMiddleware, getProfile);
export default router;
