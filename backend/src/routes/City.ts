import express from "express";
import { createCityHandler, getCitiesHandler } from "../modules/City";
import { verifyTokenMiddleware } from "../middlewares/auth";
import { requireAdmin } from "../middlewares/adminauth"; 

const router = express.Router();

router.get('/all', getCitiesHandler);


router.post('/create', verifyTokenMiddleware, requireAdmin, createCityHandler);

export default router;
