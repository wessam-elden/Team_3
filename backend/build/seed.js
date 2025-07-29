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
const userRepo_1 = require("./Repos/userRepo");
const cityRepo_1 = require("./Repos/cityRepo");
const LandmarkRepo_1 = require("./Repos/LandmarkRepo");
const visitRepo_1 = require("./Repos/visitRepo");
const bcryptjs_1 = __importDefault(require("bcryptjs"));
// You might need to adjust the import if using default exports
// Run this file with:  npx ts-node seed.ts
function seed() {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            console.log("🌱 Starting seed...");
            // 1. Create users
            const passwordHash = yield bcryptjs_1.default.hash("1234", 10);
            yield (0, userRepo_1.createUser)({
                email: "mohamed.com",
                password: passwordHash,
                name: "dr.mohamed",
                country: "Egypt",
                isverified: true,
                provider: "local",
                provider_id: null,
                phone_number: "01012345678",
                role: "admin",
                verification_code: null,
            });
            yield (0, userRepo_1.createUser)({
                email: "ehab.com",
                password: passwordHash,
                name: "dr.ehab",
                country: "Egypt",
                isverified: true,
                provider: "local",
                provider_id: null,
                phone_number: "01012345678",
                role: "admin",
                verification_code: null,
            });
            yield (0, userRepo_1.createUser)({
                email: "youssef.com",
                password: passwordHash,
                name: "youssef",
                country: "Egypt",
                isverified: true,
                provider: "local",
                provider_id: null,
                phone_number: "01143261631",
                role: "TOURIST",
                verification_code: null,
            });
            yield (0, userRepo_1.createUser)({
                email: "wael.com",
                password: passwordHash,
                name: "wael",
                country: "Egypt",
                isverified: true,
                provider: "local",
                provider_id: null,
                phone_number: "01144948718",
                role: "TOURIST",
                verification_code: null,
            });
            // 2. Create cities
            const cairo = yield (0, cityRepo_1.createCity)("Cairo");
            const luxor = yield (0, cityRepo_1.createCity)("Luxor");
            const fayoum = yield (0, cityRepo_1.createCity)("Fayoum");
            // 3. Create landmarks
            const pyramids = yield (0, LandmarkRepo_1.createLandmark)({
                name: "Pyramids of Giza",
                description: "Ancient pyramids",
                location: "Giza Plateau",
                image_url: "https://example.com/pyramids.jpg",
                opening_hours: "8 AM - 5 PM",
                ticket_price: 200,
                City_id: cairo.id,
            });
            const karnak = yield (0, LandmarkRepo_1.createLandmark)({
                name: "Karnak Temple",
                description: "Famous temple complex",
                location: "Luxor",
                image_url: "https://example.com/karnak.jpg",
                opening_hours: "9 AM - 4 PM",
                ticket_price: 150,
                City_id: luxor.id,
            });
            // 4. Create visits (you must manually find userId from DB or add a `getUserByEmail` function)
            // Example only if you already know user IDs:
            yield (0, visitRepo_1.createVisit)({
                User_id: 1, // Replace with actual user id
                City_id: cairo.id,
                Landmark_id: pyramids.id,
                rating: 5,
                opinion: "Amazing experience!",
                isfavorite: true,
                visit_date: new Date("2024-07-15"),
            });
            console.log("✅ Seed finished successfully.");
            process.exit(0);
        }
        catch (error) {
            console.error("❌ Seed failed:", error);
            process.exit(1);
        }
    });
}
seed();
