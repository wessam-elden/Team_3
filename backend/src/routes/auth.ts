// routes/auth.ts
import { Router } from 'express';
import { getProfile, login, signup } from '../modules/auth';
import { verifyTokenMiddleware } from '../middlewares/auth';
import { createVisitHandler, getAllVisitsHandler } from '../modules/visit';
import { requestPasswordReset, verifyOtp, resetPasswordWithOtp } from '../modules/passwordReset';

const router = Router();

router.post('/signup', signup);

router.post('/login', login); 



// Password Reset with OTP
router.post('/request-password-reset', requestPasswordReset); // Step 1
router.post('/verify-otp', verifyOtp);                         // Step 2
router.post('/reset-password', resetPasswordWithOtp);         // Step 3



router.get("/profile", verifyTokenMiddleware, getProfile);
export default router;
