"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// routes/auth.ts
const express_1 = require("express");
const auth_1 = require("../modules/auth");
const auth_2 = require("../middlewares/auth");
const router = (0, express_1.Router)();
router.post('/signup', auth_1.signup);
router.post('/login', auth_1.login);
router.get("/profile", auth_2.verifyTokenMiddleware, auth_1.getProfile);
exports.default = router;
