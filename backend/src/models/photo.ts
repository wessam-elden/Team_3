import { RowDataPacket } from "mysql2";

export interface photo extends RowDataPacket {
    id: number;
    photo_url: string;
    landmark_id: number;
    User_id: number;
}