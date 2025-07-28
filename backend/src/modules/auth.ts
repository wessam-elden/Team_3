// modules/auth.ts
import { Request, Response } from "express";
import { createUser, getUserByEmail } from "../Repos/userRepo";
import { comparePassword, hashPassword } from "../utilites/hash";
import { generateToken } from "../utilites/jwt";
import { AuthRequest } from "../middlewares/auth";

export async function signup(req: Request, res: Response) {
  try {
    const { email, password, name } = req.body;

    if(
  typeof email !== "string" ||
  typeof password !== "string" ||
  typeof name !== "string" ||
  !email.trim() ||
  !password.trim() ||
  !name.trim()
) {
  return res.status(400).json({ message: "Missing or invalid required fields" });
}

    const existing = await getUserByEmail(email);
    if (existing) {
      return res.status(409).json({ message: "User already exists" });
    }

    const hashed = await hashPassword(password);

    await createUser({
      email,
      password: hashed,
      name,
      country: "", // Optional default values if needed
      isverified: false,
      provider: "GOOGLE", // Or default
      provider_id: 0,
      phone_number: "",
      role: "TOURIST",
      verification_code: Math.floor(1000 + Math.random() * 9000).toString(),
    });

    res.status(201).json({ message: "User created successfully" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Internal server error" });
  }
}

export async function login(req: Request, res: Response) {
  try {
    const { email, password } = req.body;
    if (typeof email != "string" || typeof password != "string" || !email.trim() || !password.trim())
      return res.status(400).json({ message: "Email and password required" });

    const user = await getUserByEmail(email);
    if (!user)
      return res.status(401).json({ message: "Invalid email or password" });

    const isPasswordValid =  comparePassword(password, user.password);

    if (!isPasswordValid)
      return res.status(401).json({ message: "Invalid password" });

    const payload = {
      id: user.id,
      email: user.email,
      role: user.role,
    };

    const token = generateToken(payload);

    return res.json({ token, message: "Login successful" });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: "Internal server error" });
  }
}

export async function getProfile(req: AuthRequest, res: Response) {
  try {
    const email = req.user?.email;
    if (!email) {
      return res.status(400).json({ message: "Invalid request: no user email" });
    }

    const user = await getUserByEmail(email);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // Only return selected safe fields
    const { id, name, email: safeEmail, role, isVerified,country,phone_number } = user;

    return res.status(200).json({
      success: true,
      message: "User profile fetched successfully",
      data: {
        id,
        name,
        email: safeEmail,
        role,
        isVerified,
        country,
        phone_number
        
      },
    });
  } catch (error) {
    console.error("getProfile error:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
}

