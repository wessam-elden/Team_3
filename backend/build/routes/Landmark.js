"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const Landmark_1 = require("../modules/Landmark");
const auth_1 = require("../middlewares/auth");
const adminauth_1 = require("../middlewares/adminauth");
const router = express_1.default.Router();
// GET all landmarks
router.get("/all", auth_1.verifyTokenMiddleware, Landmark_1.getAllLandmarksHandler);
// GET landmarks by city ID
router.get("/by-city/:cityId", auth_1.verifyTokenMiddleware, Landmark_1.getLandmarkesByCityHandler);
router.post("/create", auth_1.verifyTokenMiddleware, adminauth_1.requireAdmin, Landmark_1.createLandmarkHandler);
exports.default = router;
