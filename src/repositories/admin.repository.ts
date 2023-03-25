import { Admin, Sessions } from '@prisma/client';

export abstract class AdminRepository {
  abstract create(name: string, password: string): Promise<Admin>;
  abstract getAdminsByName(name: string): Promise<Admin[]>;
  abstract createSession(adminId: number, token: string): Promise<Sessions>;
}
