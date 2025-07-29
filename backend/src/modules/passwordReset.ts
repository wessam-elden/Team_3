import { Request, Response } from "express";
import crypto from "crypto";
import { getUserByEmail, updateUserPassword } from "../Repos/userRepo";
import { sendResetEmail } from "../utilites/mailer";
import bcrypt from "bcryptjs";

// مؤقتًا، نخزن OTP في الذاكرة 
const otpStore: Map<string, { otp: string, expires: number, verified?: boolean }> = new Map();

// Step 1: إرسال OTP للمستخدم
export async function requestPasswordReset(req: Request, res: Response) {
  const { email } = req.body;

  const user = await getUserByEmail(email);
  if (!user) {
    return res.status(404).json({ message: "User not found" });
  }

  const otp = Math.floor(1000 + Math.random() * 9000).toString(); // 4 ارقام فقط
  const expires = Date.now() + 5 * 60 * 1000; // 5 دقائق

  otpStore.set(email, { otp, expires });

  await sendResetEmail(email, otp); // إرسال OTP

  res.json({ message: "OTP sent to email" });
}

// Step 2: التحقق من OTP
export async function verifyOtp(req: Request, res: Response) {
  const { email, otp } = req.body;

  const record = otpStore.get(email);
  if (!record) {
    return res.status(400).json({ message: "No OTP requested" });
  }

  if (record.otp !== otp) {
    return res.status(400).json({ message: "Invalid OTP" });
  }

  if (Date.now() > record.expires) {
    otpStore.delete(email);
    return res.status(400).json({ message: "OTP expired" });
  }

  // تأكيد أن OTP صحيح
  otpStore.set(email, { ...record, verified: true });

  res.json({ message: "OTP verified. You can now reset your password." });
}

// Step 3: تغيير الباسورد بعد التحقق
export async function resetPasswordWithOtp(req: Request, res: Response) {
  const { email, newPassword } = req.body;

  const record = otpStore.get(email);
  if (!record || !record.verified) {
    return res.status(400).json({ message: "OTP not verified" });
  }

  const hashed = await bcrypt.hash(newPassword, 10);
  const updated = await updateUserPassword(email, hashed);

  otpStore.delete(email);

  if (updated) {
    res.json({ message: "Password updated successfully" });
  } else {
    res.status(500).json({ message: "Failed to update password" });
  }
}
