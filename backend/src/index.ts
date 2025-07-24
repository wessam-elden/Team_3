// index.ts
import express from 'express';
import authRoutes from './routes/auth';
import cityRoutes from './routes/City'; // ✅ add city route
import landmarkRoutes from './routes/Landmark'; // ✅ add landmark route
import dotenv from 'dotenv';


dotenv.config();


const app = express();
app.use(express.json());

app.use('/auth', authRoutes);
app.use("/cities", cityRoutes); // ✅ add city route
app.use("/landmarkes", landmarkRoutes); // ✅ add landmark route)

const PORT = 4040;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));


