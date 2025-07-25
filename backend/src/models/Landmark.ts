import { RowDataPacket } from "mysql2";

export interface Landmark extends RowDataPacket {
    id: number;
    name: string;
    description: string;
    location: string;
    image_url: string;
    opening_hours: string;
    ticket_price: number;
    City_id: number;
}