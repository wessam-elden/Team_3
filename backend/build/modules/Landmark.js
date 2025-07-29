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
exports.getAllLandmarksHandler = getAllLandmarksHandler;
exports.getLandmarkesByCityHandler = getLandmarkesByCityHandler;
exports.createLandmarkHandler = createLandmarkHandler;
const LandmarkRepo_1 = require("../Repos/LandmarkRepo");
// Handler to get ALL landmarks
function getAllLandmarksHandler(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const landmarks = yield (0, LandmarkRepo_1.getAllLandmarks)();
            console.log("getAllLandmarksHandler executed successfully");
            return res.status(200).json({
                success: true,
                message: "All landmarks retrieved successfully",
                data: landmarks,
            });
        }
        catch (error) {
            console.error("getAllLandmarksHandler error:", error);
            return res.status(500).json({ message: "Internal server error" });
        }
    });
}
// Handler to get landmarks of a specific city
function getLandmarkesByCityHandler(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const cityId = parseInt(req.params.cityId);
            if (isNaN(cityId)) {
                return res.status(400).json({ message: "Invalid or missing city ID" });
            }
            const landmarks = yield (0, LandmarkRepo_1.getLandmarksByCity)(cityId);
            console.log("getLandmarkesByCityHandler executed successfully for cityId:", cityId);
            return res.status(200).json({
                success: true,
                message: "City landmarks retrieved successfully",
                data: landmarks,
            });
        }
        catch (error) {
            console.error("getLandmarkesByCityHandler error:", error);
            return res.status(500).json({ message: "Internal server error" });
        }
    });
}
function createLandmarkHandler(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const { name, description, location, image_url, opening_hours, ticket_price, City_id // ✅ use lowercase
             } = req.body;
            // Basic validation
            if (!name || !City_id || !location) {
                return res.status(400).json({ message: "Missing required fields" });
            }
            const newLandmark = yield (0, LandmarkRepo_1.createLandmark)({
                name,
                description,
                location,
                image_url,
                opening_hours,
                ticket_price,
                City_id // ✅ match
            });
            return res.status(201).json({
                success: true,
                message: "Landmark created successfully",
                data: newLandmark
            });
        }
        catch (error) {
            console.error("createLandmarkHandler error:", error);
            return res.status(500).json({ message: "Internal server error" });
        }
    });
}
