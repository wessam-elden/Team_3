// routes/City.ts
import express from "express";
import { createCityHandler, getCitiesHandler } from "../modules/City";

const router = express.Router();


router.get('/all', getCitiesHandler); // Endpoint to get all cities
router.post('/create', createCityHandler); // Endpoint to create a new city
export default router;
