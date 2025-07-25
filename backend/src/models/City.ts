import { RowDataPacket } from "mysql2";

export interface City extends RowDataPacket {
    id: number;
    name: string;
}