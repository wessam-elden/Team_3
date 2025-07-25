import { pool } from "../utilites/db";
import { Landmark } from "../models/Landmark";

// All landmarks
export async function getAllLandmarks(): Promise<Landmark[]> {
  const [rows] = await pool.query("SELECT * FROM Landmark");
  console.log("getAllLandmarks executed successfully");
  return rows as Landmark[];
}

// Landmarks by city
export async function getLandmarksByCity(cityId: number): Promise<Landmark[]> {
  const [rows] = await pool.query("SELECT * FROM Landmark WHERE city_id = ?", [cityId]);
  console.log("getLandmarksByCity executed successfully for cityId:", cityId);
  return rows as Landmark[];
}
export async function createLandmark(data: Omit<Landmark, "id">): Promise<Landmark> {
  const {
    name,
    description,
    location,
    image_url,
    opening_hours,
    ticket_price,
    City_id,
  } = data;

  const [result] = await pool.query(
    `INSERT INTO Landmark (name, description, location, image_url, opening_hours, ticket_price, City_id)
     VALUES (?, ?, ?, ?, ?, ?, ?)`,
    [name, description, location, image_url, opening_hours, ticket_price, City_id]
  );

  const insertedId = (result as any).insertId;

  return {
  id: insertedId,
  ...data,
  } as Landmark; 
};
