import {
  Controller,
  Body,
  Post,
  InternalServerErrorException,
  BadRequestException,
} from '@nestjs/common';
import { CreateAdminBody } from 'src/dtos/create-admin-body';
import { AuthService } from './auth.service';

@Controller()
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('signup')
  async createAdmin(@Body() body: CreateAdminBody): Promise<any> {
    const { name, password } = body;

    try {
      await this.authService.createAdmin(name, password);
    } catch (error) {
      if (error.name === 'BadRequestException') {
        throw new BadRequestException();
      }
      throw new InternalServerErrorException();
    }
  }
  @Post('signin')
  async login(@Body() body: CreateAdminBody): Promise<any> {
    const { name, password } = body;

    try {

      return await this.authService.login(name, password);
    } catch (error) {
        
      if (error.name === 'BadRequestException') {
        throw new BadRequestException();
      }
      throw new InternalServerErrorException();
    }
  }
}
