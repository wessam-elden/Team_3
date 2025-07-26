
import { Router } from "express";
import { createVisitHandler, getAllVisitsHandler } from "../modules/visit";
import { verifyTokenMiddleware } from "../middlewares/auth";



const router = Router();



router.post("/create", verifyTokenMiddleware, createVisitHandler);

router.get("/getAll", verifyTokenMiddleware, getAllVisitsHandler);

export default router;
