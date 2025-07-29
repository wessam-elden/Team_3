import { Request, Response } from "express";
import { createLandmark, getAllLandmarks, getLandmarksByCity } from "../Repos/LandmarkRepo";
import xss from "xss";

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
    let {
      name,
      description,
      location,
      image_url,
      opening_hours,
      ticket_price,
      City_id,
    } = req.body;

    // Basic validation
    if (
      typeof name !== "string" ||
      typeof location !== "string" ||
      !name.trim() ||
      !location.trim() ||
      !City_id
    ) {
      return res.status(400).json({ message: "Missing or invalid required fields" });
    }

    // 🔐 Sanitize all text inputs
    name = xss(name.trim());
    location = xss(location.trim());
    if (typeof description === "string") description = xss(description.trim());
    if (typeof image_url === "string") image_url = xss(image_url.trim());
    if (typeof opening_hours === "string") opening_hours = xss(opening_hours.trim());

    const newLandmark = await createLandmark({
      name,
      description,
      location,
      image_url,
      opening_hours,
      ticket_price,
      City_id,
    });

    return res.status(201).json({
      success: true,
      message: "Landmark created successfully",
      data: {
        ...newLandmark,
        name: xss(newLandmark.name), // double sanitize for safety
        description: xss(newLandmark.description),
      },
    });
  } catch (error) {
    console.error("createLandmarkHandler error:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
}


