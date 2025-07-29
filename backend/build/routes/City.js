"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const City_1 = require("../modules/City");
const auth_1 = require("../middlewares/auth");
const adminauth_1 = require("../middlewares/adminauth");
const router = express_1.default.Router();
router.get('/all', auth_1.verifyTokenMiddleware, City_1.getCitiesHandler);
router.post('/create', auth_1.verifyTokenMiddleware, adminauth_1.requireAdmin, City_1.createCityHandler);
exports.default = router;
