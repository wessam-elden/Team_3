import { Response, NextFunction } from "express";
import { AuthRequest } from "./auth"; // أو حسب مكان تعريف AuthRequest

export function requireAdmin(req: AuthRequest, res: Response, next: NextFunction) {
  if (!req.user || req.user.role !== "ADMIN") {
    return res.status(403).json({ message: "Access denied. Admins only." });
  }
  next();
}
