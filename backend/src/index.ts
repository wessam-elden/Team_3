// index.ts
import express from 'express';
import authRoutes from './routes/auth';
import cityRoutes from './routes/City'; // ✅ add city route
import landmarkRoutes from './routes/Landmark'; // ✅ add landmark route
import visitRoutes from './routes/visit'; // ✅ add visit route
import dotenv from 'dotenv';


dotenv.config();


const app = express();
app.use(express.json());

app.use('/auth', authRoutes);
app.use("/city", cityRoutes); // ✅ add city route
app.use("/landmark", landmarkRoutes); // ✅ add landmark route)
app.use("/visit", visitRoutes);

const PORT = 4040;
app.listen(PORT,'0.0.0.0', () => console.log(`Server running on port ${PORT}`));


