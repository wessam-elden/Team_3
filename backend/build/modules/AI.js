"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.handleChat = handleChat;
exports.detectHandler = detectHandler;
const AI_1 = require("../utilites/AI"); // wherever your function is
function handleChat(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const { question } = req.body;
            // validate input
            if (!question || typeof question !== 'string') {
                return res.status(400).json({ message: 'Invalid question' });
            }
            const response = yield (0, AI_1.sendChatMessage)({ question });
            return res.status(200).json(response);
        }
        catch (error) {
            console.error('Chat handler error:', error.message);
            return res.status(500).json({ message: 'Internal Server Error' });
        }
    });
}
function detectHandler(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        var _a;
        try {
            const imagePath = (_a = req.file) === null || _a === void 0 ? void 0 : _a.path;
            if (!imagePath) {
                return res.status(400).json({ error: 'Image file is required' });
            }
            const result = yield (0, AI_1.detectLandmark)(imagePath);
            res.json(result);
        }
        catch (error) {
            res.status(500).json({ error: error.message });
        }
    });
}
