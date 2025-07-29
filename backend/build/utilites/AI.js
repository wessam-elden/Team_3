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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.sendChatMessage = sendChatMessage;
exports.detectLandmark = detectLandmark;
const fs_1 = __importDefault(require("fs"));
const form_data_1 = __importDefault(require("form-data"));
const node_fetch_1 = __importDefault(require("node-fetch")); // make sure this is installed
function sendChatMessage(data) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const res = yield (0, node_fetch_1.default)('http://127.0.0.1:1234/chat', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data),
            });
            const resJson = yield res.json();
            if (!res.ok) {
                const errMessage = (resJson === null || resJson === void 0 ? void 0 : resJson.message) || 'Chat request failed';
                throw new Error(errMessage);
            }
            // Optional: validate structure
            if (typeof resJson !== 'object' ||
                resJson === null ||
                !('answer' in resJson) ||
                !('response_time_sec' in resJson)) {
                throw new Error('Invalid response format from API');
            }
            return resJson;
        }
        catch (error) {
            console.error('Chat API Error:', error.message);
            throw error;
        }
    });
}
function detectLandmark(imagePath) {
    return __awaiter(this, void 0, void 0, function* () {
        const form = new form_data_1.default();
        form.append('image', fs_1.default.createReadStream(imagePath));
        try {
            const response = yield (0, node_fetch_1.default)('http://127.0.0.1:5000/detect', {
                method: 'POST',
                body: form, // fix TypeScript complaint
                headers: form.getHeaders(), // needed for multipart form
            });
            if (!response.ok) {
                throw new Error(`Flask service error: ${response.statusText}`);
            }
            const data = yield response.json();
            return data; // { landmark, description, image }
        }
        catch (err) {
            console.error('Detection error:', err);
            throw err;
        }
    });
}
