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
exports.getAllLandmarks = getAllLandmarks;
exports.getLandmarksByCity = getLandmarksByCity;
exports.createLandmark = createLandmark;
const db_1 = require("../utilites/db");
// All landmarks
function getAllLandmarks() {
    return __awaiter(this, void 0, void 0, function* () {
        const [rows] = yield db_1.pool.query("SELECT * FROM Landmark");
        console.log("getAllLandmarks executed successfully");
        return rows;
    });
}
// Landmarks by city
function getLandmarksByCity(cityId) {
    return __awaiter(this, void 0, void 0, function* () {
        const [rows] = yield db_1.pool.query("SELECT * FROM Landmark WHERE city_id = ?", [cityId]);
        console.log("getLandmarksByCity executed successfully for cityId:", cityId);
        return rows;
    });
}
function createLandmark(data) {
    return __awaiter(this, void 0, void 0, function* () {
        const { name, description, location, image_url, opening_hours, ticket_price, City_id, } = data;
        const [result] = yield db_1.pool.query(`INSERT INTO Landmark (name, description, location, image_url, opening_hours, ticket_price, City_id)
     VALUES (?, ?, ?, ?, ?, ?, ?)`, [name, description, location, image_url, opening_hours, ticket_price, City_id]);
        const insertedId = result.insertId;
        return Object.assign({ id: insertedId }, data);
    });
}
;
