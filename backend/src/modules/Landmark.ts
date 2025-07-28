import { Request, Response } from "express";
import { createLandmark, getAllLandmarks, getLandmarksByCity } from "../Repos/LandmarkRepo";

// Handler to get ALL landmarks
export async function getAllLandmarksHandler(req: Request, res: Response) {
  try {
    const landmarks = await getAllLandmarks();
    console.log("getAllLandmarksHandler executed successfully");

    return res.status(200).json({
      success: true,
      message: "All landmarks retrieved successfully",
      data: landmarks,
    });
  } catch (error) {
    console.error("getAllLandmarksHandler error:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
}

// Handler to get landmarks of a specific city
export async function getLandmarkesByCityHandler(req: Request, res: Response) {
  try {
    const cityId = parseInt(req.params.cityId);
    if (isNaN(cityId)) {
      return res.status(400).json({ message: "Invalid or missing city ID" });
    }

    const landmarks = await getLandmarksByCity(cityId);
    console.log("getLandmarkesByCityHandler executed successfully for cityId:", cityId);

    return res.status(200).json({
      success: true,
      message: "City landmarks retrieved successfully",
      data: landmarks,
    });
  } catch (error) {
    console.error("getLandmarkesByCityHandler error:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
}

export async function createLandmarkHandler(req: Request, res: Response) {
  try {
    const {
      name,
      description,
      location,
      image_url,
      opening_hours,
      ticket_price,
      City_id // ✅ use lowercase
    } = req.body;

    // Basic validation
    if (!name || !City_id || !location) {
      return res.status(400).json({ message: "Missing required fields" });
    }

    const newLandmark = await createLandmark({
      name,
      description,
      location,
      image_url,
      opening_hours,
      ticket_price,
      City_id // ✅ match
    });

    return res.status(201).json({
      success: true,
      message: "Landmark created successfully",
      data: newLandmark
    });
  } catch (error) {
    console.error("createLandmarkHandler error:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
}


