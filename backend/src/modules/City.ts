import { Request, Response } from "express";
import { createCity, getAllCities } from "../Repos/cityRepo";
import xss from "xss";

export async function getCitiesHandler(req: Request, res: Response) {
  try {
    const cities = await getAllCities();
    return res.status(200).json({
      success: true,
      message: "Cities retrieved successfully",
      data: cities,
    });
  } catch (error) {
    return res.status(500).json({ message: "Internal server error" });
  }
}

export async function createCityHandler(req: Request, res: Response) {
  try {
    let { name } = req.body;

    if (typeof name !== "string" || !name.trim()) {
      return res.status(400).json({ message: "City name is required and must be a string" });
    }

    // 🔐 Sanitize input to prevent XSS
    name = xss(name.trim());

    const newCity = await createCity(name);

    // Optional: sanitize again before returning (usually unnecessary if you sanitized before saving)
    return res.status(201).json({
      success: true,
      message: "City created successfully",
      data: {
        id: newCity.id,
        name: xss(newCity.name),
      },
    });
  } catch (error) {
    return res.status(500).json({ message: "Internal server error" });
  }
}