import { RowDataPacket } from "mysql2";

export interface visit extends RowDataPacket {
    id: number;
    User_id: number;
    City_id: number;
    Landmark_id: number;
    rating: number;
    opinion: string;
    isfavorite: boolean;
    visit_date: Date;
}