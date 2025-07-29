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
exports.createVisitHandler = createVisitHandler;
exports.getAllVisitsHandler = getAllVisitsHandler;
const visitRepo_1 = require("../Repos/visitRepo");
function createVisitHandler(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const { cityId, landmarkId, rating, opinion, isfavorite, visitDate } = req.body;
            if (!req.user || typeof req.user.id !== 'number') {
                return res.status(401).json({ message: "Unauthorized" });
            }
            if (!cityId || !landmarkId || !visitDate) {
                return res.status(400).json({ message: "Missing required fields: cityId, landmarkId, visitDate" });
            }
            yield (0, visitRepo_1.createVisit)({
                User_id: req.user.id,
                City_id: cityId,
                Landmark_id: landmarkId,
                rating,
                opinion,
                isfavorite,
                visit_date: new Date(visitDate)
            });
            return res.status(201).json({
                success: true,
                message: "Visit recorded successfully"
            });
        }
        catch (err) {
            console.error("createVisitHandler error:", err);
            return res.status(500).json({ message: "Internal server error" });
        }
    });
}
function getAllVisitsHandler(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            if (!req.user || typeof req.user.id !== 'number') {
                return res.status(401).json({ message: "Unauthorized" });
            }
            const visits = yield (0, visitRepo_1.getVisitsByUserId)(req.user.id);
            return res.json({ success: true, visits });
        }
        catch (err) {
            console.error("getAllVisitsHandler error:", err);
            return res.status(500).json({ message: "Internal server error" });
        }
    });
}
