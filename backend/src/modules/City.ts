import { Request, Response } from "express";
import { createCity, getAllCities } from "../Repos/cityRepo";

export async function getCitiesHandler(req: Request, res: Response) {
  try {
    const cities = await getAllCities();
    return res.status(200).json({
      success: true,
      message: "Cities retrieved successfully",
      data: cities,
    });
  } catch (error) {
    console.error("getCitiesHandler error:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
  console.log("getCitiesHandler executed successfully");  
}

export async function createCityHandler(req: Request, res: Response) {
  try {
    const { name } = req.body;
    if (typeof name !== "string" || !name.trim()) {
      return res.status(400).json({ message: "City name is required and must be a string" });
    }

    const newCity = await createCity(name.trim());
    return res.status(201).json({
      success: true,
      message: "City created successfully",
      data: newCity,
    });
  } catch (error) {
    console.error("createCityHandler error:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
}