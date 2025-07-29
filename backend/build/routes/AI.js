"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// routes/auth.ts
const express_1 = require("express");
const auth_1 = require("../middlewares/auth");
const AI_1 = require("../modules/AI");
const multer_1 = __importDefault(require("multer"));
const router = (0, express_1.Router)();
router.post('/chat', auth_1.verifyTokenMiddleware, AI_1.handleChat);
const upload = (0, multer_1.default)({ dest: 'uploads/' });
router.post('/detect', upload.single('image'), auth_1.verifyTokenMiddleware, AI_1.detectHandler);
exports.default = router;
