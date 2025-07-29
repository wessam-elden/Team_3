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
exports.getAllCities = getAllCities;
exports.createCity = createCity;
const db_1 = require("../utilites/db"); // assuming you're using a db instance here
function getAllCities() {
    return __awaiter(this, void 0, void 0, function* () {
        const [rows] = yield db_1.pool.query("SELECT * FROM city");
        return rows;
        console.log("getAllCities executed successfully");
    });
}
function createCity(name) {
    return __awaiter(this, void 0, void 0, function* () {
        const [result] = yield db_1.pool.query("INSERT INTO City (name) VALUES (?)", [name]);
        const insertedId = result.insertId;
        return { id: insertedId, name };
    });
}
