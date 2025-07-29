"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// index.ts
const express_1 = __importDefault(require("express"));
const auth_1 = __importDefault(require("./routes/auth"));
const City_1 = __importDefault(require("./routes/City")); // ✅ add city route
const Landmark_1 = __importDefault(require("./routes/Landmark")); // ✅ add landmark route
const visit_1 = __importDefault(require("./routes/visit")); // ✅ add visit route
const AI_1 = __importDefault(require("./routes/AI")); // ✅ add AI route
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
const app = (0, express_1.default)();
app.use(express_1.default.json());
app.use('/auth', auth_1.default);
app.use("/city", City_1.default); // ✅ add city route
app.use("/landmark", Landmark_1.default); // ✅ add landmark route)
app.use("/visit", visit_1.default);
app.use('/AI', AI_1.default);
const PORT = 4040;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
