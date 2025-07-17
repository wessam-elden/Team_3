export interface User{
    idUser: number;
    email: string;
    password: string;
    name: string;
    country: string;
    isverified: boolean;
    created_at: Date;
    login_type: string;
    phone_number: string;
    role: 'tourist' | 'guide' | 'admin';
    verification_code?: string;
}