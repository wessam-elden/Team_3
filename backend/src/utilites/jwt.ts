// Utilities/jwt.ts
import jwt from 'jsonwebtoken';

const SECRET = process.env.JWT_SECRET || 'fallback_secret';

export function generateToken(payload: object) {
  return jwt.sign(payload, SECRET, { expiresIn: '7d' }); // valid for 7 days
}

export function verifyToken(token: string) {
  return jwt.verify(token, SECRET);
}
