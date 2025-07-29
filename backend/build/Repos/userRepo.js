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
exports.createUser = createUser;
exports.getUserByEmail = getUserByEmail;
const db_1 = require("../utilites/db");
function createUser(user) {
    return __awaiter(this, void 0, void 0, function* () {
        const { email, password, name, country, isverified, provider, provider_id, phone_number, role, verification_code } = user;
        const query = `
    INSERT INTO user 
    (email, password, name, country, isverified, provider, provider_id, phone_number, role)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
  `;
        yield db_1.pool.execute(query, [
            email, password, name, country, isverified, provider,
            provider_id, phone_number, role
        ]);
    });
}
function getUserByEmail(email) {
    return __awaiter(this, void 0, void 0, function* () {
        const [rows] = yield db_1.pool.execute("SELECT * FROM user WHERE email = ?", [email]);
        const users = rows;
        return users.length ? users[0] : null;
    });
}
