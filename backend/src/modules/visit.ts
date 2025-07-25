import { Request, Response } from "express";
import { createVisit, getVisitsByUserId } from "../Repos/visitRepo";
import { AuthRequest } from "../middlewares/auth";

export async function createVisitHandler(req: AuthRequest, res: Response) {
  try {
    const { cityId, landmarkId, rating, opinion, isfavorite, visitDate } = req.body;

    if (!req.user || typeof req.user.id !== 'number') {
  return res.status(401).json({ message: "Unauthorized" });
}


    if (!cityId || !landmarkId || !visitDate) {
      return res.status(400).json({ message: "Missing required fields: cityId, landmarkId, visitDate" });
    }

    await createVisit({
  User_id: req.user.id,
  City_id: cityId,
  Landmark_id: landmarkId,
  rating,
  opinion,
  isfavorite,
  visit_date: new Date(visitDate)
});



    return res.status(201).json({
      success: true,
      message: "Visit recorded successfully"
    });
  } catch (err) {
    console.error("createVisitHandler error:", err);
    return res.status(500).json({ message: "Internal server error" });
  }
}
export async function getAllVisitsHandler(req: AuthRequest, res: Response) {
  try {
    if (!req.user || typeof req.user.id !== 'number') {
  return res.status(401).json({ message: "Unauthorized" });
}


    const visits = await getVisitsByUserId(req.user.id);

    return res.json({ success: true, visits });
  } catch (err) {
    console.error("getAllVisitsHandler error:", err);
    return res.status(500).json({ message: "Internal server error" });
  }
}