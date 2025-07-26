import { RowDataPacket } from "mysql2";


export interface User extends RowDataPacket {
    id: number;
    email: string;
    password: string;
    name: string;
    country: string;
    isverified: boolean;
    created_at: Date;
    provider: 'GOOGLE' | 'FACEBOOK';
    provider_id: number;
    phone_number: string;
    role: 'TOURIST' | 'GUIDE' | 'ADMIN';
    verification_code?: string;
}