import { Module } from '@nestjs/common';
import { JwtModule, JwtService } from '@nestjs/jwt';
import { PrismaService } from 'src/database/prisma.service';
import { AdminRepository } from 'src/repositories/admin.repository';
import { PrismaAdminRepository } from 'src/repositories/prisma/prisma-admin.repository';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
@Module({
  imports: [
    JwtModule.register({
      secret: process.env.SECRET_TOKEN,
      signOptions: { expiresIn: '3600s' },
    }),
  ],
  controllers: [AuthController],
  providers: [
    AuthService,
    PrismaService,
    {
      provide: AdminRepository,
      useClass: PrismaAdminRepository,
    }
  ],
})
export class AuthModule {}
