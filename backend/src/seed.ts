import { createUser } from "./Repos/userRepo";
import { createCity } from "./Repos/cityRepo";
import { createLandmark } from "./Repos/LandmarkRepo";
import { createVisit } from "./Repos/visitRepo";
import bcrypt from "bcryptjs";

// You might need to adjust the import if using default exports
// Run this file with:  npx ts-node seed.ts

async function seed() {
  try {
    console.log("🌱 Starting seed...");

    // 1. Create users
    const passwordHash = await bcrypt.hash("1234", 10);

    await createUser({
      email: "mohamed.com",
      password: passwordHash,
      name: "dr.mohamed",
      country: "Egypt",
      isverified: true,
      provider: "local",
      provider_id: null,
      phone_number: "01012345678",
      role: "admin",
      verification_code: null,
    });

    await createUser({
      email: "ehab.com",
      password: passwordHash,
      name: "dr.ehab",
      country: "Egypt",
      isverified: true,
      provider: "local",
      provider_id: null,
      phone_number: "01012345678",
      role: "admin",
      verification_code: null,
    });

    await createUser({
      email: "youssef.com",
      password: passwordHash,
      name: "youssef",
      country: "Egypt",
      isverified: true,
      provider: "local",
      provider_id: null,
      phone_number: "01143261631",
      role: "TOURIST",
      verification_code: null,
    });
    await createUser({
      email: "wael.com",
      password: passwordHash,
      name: "wael",
      country: "Egypt",
      isverified: true,
      provider: "local",
      provider_id: null,
      phone_number: "01144948718",
      role: "TOURIST",
      verification_code: null,
    });

    // 2. Create cities
    const Giza = await createCity("Giza");
    const luxor = await createCity("Luxor");
    const fayoum = await createCity("Fayoum");


    // 3. Create landmarks
    const pyramids = await createLandmark({
      name: "Pyramids of Giza",
      description: "Ancient pyramids",
      location: "Giza Plateau",
      image_url: "./landmark_photo/pyramid.jpg",
      opening_hours: "8 AM - 5 PM",
      ticket_price: 200,
      City_id: Giza.id,
    });

    const karnak = await createLandmark({
      name: "Karnak Temple",
      description: "Famous temple complex",
      location: "Luxor",
      image_url: "./landmark_photokarnak.jpg",
      opening_hours: "9 AM - 4 PM",
      ticket_price: 150,
      City_id: luxor.id,
    });

    // 4. Create visits (you must manually find userId from DB or add a `getUserByEmail` function)
    // Example only if you already know user IDs:
    await createVisit({
      User_id: 1, // Replace with actual user id
      City_id: Giza.id,
      Landmark_id: pyramids.id,
      rating: 5,
      opinion: "Amazing experience!",
      isfavorite: true,
      visit_date: new Date("2024-07-15"),
    });

    console.log("✅ Seed finished successfully.");
    process.exit(0);
  } catch (error) {
    console.error("❌ Seed failed:", error);
    process.exit(1);
  }
}

seed();
