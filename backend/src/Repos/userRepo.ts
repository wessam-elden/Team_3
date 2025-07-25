import { User } from "../models/User";
import { pool } from "../utilites/db";
import { v4 as uuidv4 } from 'uuid';

export async function createUser(user: Omit<User, "id" | "created_at">): Promise<void> {
  const id = uuidv4(); // Generate a unique ID for the user
  const {
    email, password, name, country, isverified, provider,
    provider_id, phone_number, role, verification_code
  } = user;

  const query = `
    INSERT INTO user 
    (id, email, password, name, country, isverified, provider, provider_id, phone_number, role, verification_code)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  `;

  await pool.execute(query, [
    id, email, password, name, country, isverified, provider,
    provider_id, phone_number, role, verification_code || null
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
