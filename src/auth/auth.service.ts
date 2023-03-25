import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
  UnauthorizedException,
} from '@nestjs/common';
import { Admin } from '@prisma/client';
import { AdminRepository } from 'src/repositories/admin.repository';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(
  private adminRepository: AdminRepository,
  private jwtService: JwtService
  ) {}

  async createAdmin(name: string, password: string): Promise<Admin> {
    const encryptedPassword = bcrypt.hashSync(password, 10);
    if (password.length < 8) {
      throw BadRequestException;
    }

    const admin = await this.adminRepository.create(name, encryptedPassword);
    if (!admin) {
      throw InternalServerErrorException;
    }
    return admin;
  }

  async login(name: string, password: string): Promise<string> {

    const admins = await this.adminRepository.getAdminsByName(name);
    const admin = admins[admins.length -1]

    if(!admin || !bcrypt.compareSync(password, admin.password) || !admin.valid){
      throw UnauthorizedException
    }

    const payload = {id: admin.id, time: Date.now()}

    const token = this.jwtService.sign(payload)
    
    await this.adminRepository.createSession(admin.id, token)

    return token
  }
}
