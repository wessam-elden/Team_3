import express from "express";
import { createLandmarkHandler, getAllLandmarksHandler, getLandmarkesByCityHandler } from "../modules/Landmark";

const router = express.Router();

// GET all landmarks
router.get("/all", getAllLandmarksHandler);

// GET landmarks by city ID
router.get("/by-city/:cityId", getLandmarkesByCityHandler);
router.post("/create", createLandmarkHandler);
export default router;
