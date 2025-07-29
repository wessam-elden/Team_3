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
exports.getCitiesHandler = getCitiesHandler;
exports.createCityHandler = createCityHandler;
const cityRepo_1 = require("../Repos/cityRepo");
function getCitiesHandler(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const cities = yield (0, cityRepo_1.getAllCities)();
            return res.status(200).json({
                success: true,
                message: "Cities retrieved successfully",
                data: cities,
            });
        }
        catch (error) {
            return res.status(500).json({ message: "Internal server error" });
        }
    });
}
function createCityHandler(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const { name } = req.body;
            if (typeof name !== "string" || !name.trim()) {
                return res.status(400).json({ message: "City name is required and must be a string" });
            }
            const newCity = yield (0, cityRepo_1.createCity)(name.trim());
            return res.status(201).json({
                success: true,
                message: "City created successfully",
                data: newCity,
            });
        }
        catch (error) {
            return res.status(500).json({ message: "Internal server error" });
        }
    });
}
