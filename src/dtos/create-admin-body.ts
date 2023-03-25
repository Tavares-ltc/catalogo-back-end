import { IsNotEmpty, Length } from 'class-validator';

export class CreateAdminBody {
  @IsNotEmpty({ message: 'Admin must have a name.' })
  name: string;

  @IsNotEmpty({ message: 'Admin password can not be empty.' })
  @Length(8, 255, {
    message: 'Admin password must be at least 8 characters long.',
  })
  password: string;
}
