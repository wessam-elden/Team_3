"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Config = exports.pool = void 0;
// utilities/db.ts
const promise_1 = __importDefault(require("mysql2/promise"));
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
const pool = promise_1.default.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
});
exports.pool = pool;
class Config {
}
exports.Config = Config;
Config.host = process.env.DB_HOST || "localhost";
Config.port = parseInt(process.env.PORT || "4040");
Config.secret = process.env.SECRET || "default_secret";
