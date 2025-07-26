import express from "express";
import { createLandmarkHandler, getAllLandmarksHandler, getLandmarkesByCityHandler } from "../modules/Landmark";
import { verifyTokenMiddleware } from "../middlewares/auth";
import { requireAdmin } from "../middlewares/adminauth";

const router = express.Router();

// GET all landmarks
router.get("/all", getAllLandmarksHandler);

// GET landmarks by city ID
router.get("/by-city/:cityId", getLandmarkesByCityHandler);

router.post("/create",verifyTokenMiddleware,requireAdmin, createLandmarkHandler);
export default router;
