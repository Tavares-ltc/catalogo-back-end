import { Injectable } from '@nestjs/common';
import { Admin, Sessions } from '@prisma/client';
import { PrismaService } from 'src/database/prisma.service';
import { AdminRepository } from '../admin.repository';

@Injectable()
export class PrismaAdminRepository implements AdminRepository {
  constructor(private prisma: PrismaService) {}

  async create(name: string, password: string): Promise<Admin> {
    return await this.prisma.admin.create({
      data: {
        name,
        password,
      },
    });
  }

  async getAdminsByName(name: string): Promise<Admin[]> {
    return await this.prisma.admin.findMany({ where: { name } });
  }

  async createSession(adminId: number, token: string): Promise<Sessions> {
    return await this.prisma.sessions.create({
      data: {
      admin_id: adminId,
      token,
      },
    })
  }
}
