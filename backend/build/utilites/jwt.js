"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.generateToken = generateToken;
exports.verifyToken = verifyToken;
// Utilities/jwt.ts
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const SECRET = process.env.JWT_SECRET || 'fallback_secret';
function generateToken(payload) {
    return jsonwebtoken_1.default.sign(payload, SECRET, { expiresIn: '7d' }); // valid for 7 days
}
function verifyToken(token) {
    return jsonwebtoken_1.default.verify(token, SECRET);
}
