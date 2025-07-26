import { visit } from "../models/visit";
import  {pool}  from "../utilites/db";

export async function createVisit(data: {
  User_id: number;
  City_id: number;
  Landmark_id: number;
  rating?: number;
  opinion?: string;
  isfavorite?: boolean;
  visit_date: Date;
}) {
  const [result] = await pool.execute(
    `INSERT INTO visit (User_id, City_id, Landmark_id, rating, opinion, isfavorite, visit_date)
     VALUES (?, ?, ?, ?, ?, ?, ?)`,
    [
      data.User_id,
      data.City_id,
      data.Landmark_id,
      data.rating ?? null,
      data.opinion ?? null,
      data.isfavorite ?? false,
      data.visit_date,
    ]
  );

  return result;
}

export async function getVisitsByUserId(userId: number): Promise<visit[]> {
  const [rows] = await pool.execute(
    `SELECT * FROM visit WHERE User_id = ?`,
    [userId]
  );

  return rows as visit[];
}