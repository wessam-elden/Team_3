import { pool } from "../utilites/db"; // assuming you're using a db instance here
import { City } from "../models/City";

export async function getAllCities(): Promise<City[]> {
  const [rows] = await pool.query("SELECT * FROM city");
  return rows as City[];
}
export async function createCity(name: string): Promise<City> {
  const [result] = await pool.query("INSERT INTO City (name) VALUES (?)", [name]);
  const insertedId = (result as any).insertId;
return { id: insertedId, name } as City;
}