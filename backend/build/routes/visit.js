"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const visit_1 = require("../modules/visit");
const auth_1 = require("../middlewares/auth");
const router = (0, express_1.Router)();
router.post("/create", auth_1.verifyTokenMiddleware, visit_1.createVisitHandler);
router.get("/getAll", auth_1.verifyTokenMiddleware, visit_1.getAllVisitsHandler);
exports.default = router;
