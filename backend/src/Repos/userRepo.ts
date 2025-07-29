import { User } from "../models/User";
import { pool } from "../utilites/db";
import { v4 as uuidv4 } from 'uuid';

export async function createUser(user: Omit<User, "id" | "created_at">): Promise<void> {
  const {
    email, password, name, country, isverified, provider,
    provider_id, phone_number, role, verification_code
  } = user;

  const query = `
    INSERT INTO user 
    (email, password, name, country, isverified, provider, provider_id, phone_number, role)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
  `;

  await pool.execute(query, [
    email, password, name, country, isverified, provider,
    provider_id, phone_number, role
  ]);
}



export async function getUserByEmail(email: string): Promise<User | null> {
  const [rows]: any = await pool.execute(
    "SELECT * FROM user WHERE email = ?",
    [email]
  );

  const users = rows as User[];
  return users.length ? users[0] : null;
}
