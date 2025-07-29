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
exports.signup = signup;
exports.login = login;
exports.getProfile = getProfile;
const userRepo_1 = require("../Repos/userRepo");
const hash_1 = require("../utilites/hash");
const jwt_1 = require("../utilites/jwt");
function signup(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const { email, password, name } = req.body;
            // Basic validation
            if (typeof email !== "string" ||
                typeof password !== "string" ||
                typeof name !== "string" ||
                !email.trim() ||
                !password.trim() ||
                !name.trim()) {
                return res.status(400).json({ message: "Missing or invalid required fields" });
            }
            const existing = yield (0, userRepo_1.getUserByEmail)(email);
            if (existing) {
                return res.status(409).json({ message: "User already exists" });
            }
            const hashed = yield (0, hash_1.hashPassword)(password);
            yield (0, userRepo_1.createUser)({
                email,
                password: hashed,
                name,
                country: "", // Optional default value
                isverified: false,
                provider: "GOOGLE",
                provider_id: 0,
                phone_number: "",
                role: "TOURIST",
            });
            res.status(201).json({ message: "User created successfully" });
        }
        catch (err) {
            console.error(err);
            res.status(500).json({ message: "Internal server error" });
        }
    });
}
function login(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const { email, password } = req.body;
            if (typeof email != "string" || typeof password != "string" || !email.trim() || !password.trim())
                return res.status(400).json({ message: "Email and password required" });
            const user = yield (0, userRepo_1.getUserByEmail)(email);
            if (!user)
                return res.status(401).json({ message: "Invalid email or password" });
            const isPasswordValid = (0, hash_1.comparePassword)(password, user.password);
            if (!isPasswordValid)
                return res.status(401).json({ message: "Invalid password" });
            const payload = {
                id: user.id,
                email: user.email,
                role: user.role,
            };
            const token = (0, jwt_1.generateToken)(payload);
            return res.json({ token, message: "Login successful" });
        }
        catch (error) {
            console.error(error);
            return res.status(500).json({ message: "Internal server error" });
        }
    });
}
function getProfile(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        var _a;
        try {
            const email = (_a = req.user) === null || _a === void 0 ? void 0 : _a.email;
            if (!email) {
                return res.status(400).json({ message: "Invalid request: no user email" });
            }
            const user = yield (0, userRepo_1.getUserByEmail)(email);
            if (!user) {
                return res.status(404).json({ message: "User not found" });
            }
            // Only return selected safe fields
            const { id, name, email: safeEmail, role, isVerified, country, phone_number } = user;
            return res.status(200).json({
                success: true,
                message: "User profile fetched successfully",
                data: {
                    id,
                    name,
                    email: safeEmail,
                    role,
                    isVerified,
                    country,
                    phone_number
                },
            });
        }
        catch (error) {
            console.error("getProfile error:", error);
            return res.status(500).json({ message: "Internal server error" });
        }
    });
}
