import nodemailer from "nodemailer";

export async function sendResetEmail(to: string, otp: string) {
  const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
      user: process.env.EMAIL_USER,
      pass: process.env.EMAIL_PASS,
    },
  });

  const info = await transporter.sendMail({
    from: `"Maporia Support" <${process.env.EMAIL_USER}>`,
    to,
    subject: "Your OTP for Password Reset",
    html: `
      <p>You requested a password reset.</p>
      <p>Your OTP is:</p>
      <h2>${otp}</h2>
      <p>This code will expire in 5 minutes.</p>
    `,
  });

  return info;
}
