// utilities/db.ts
import mysql from "mysql2/promise";
import dotenv from "dotenv";

dotenv.config();

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

export { pool };

class Config {
  static host: string = process.env.DB_HOST || "localhost";
  static port: number = parseInt(process.env.PORT || "4040");
  static secret: string = process.env.SECRET || "default_secret";
}

export { Config };
