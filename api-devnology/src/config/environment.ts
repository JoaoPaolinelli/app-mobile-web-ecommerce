import { registerAs } from '@nestjs/config';

export default registerAs('api', () => ({
  brazilianBaseUrl: process.env.BRAZILIAN_PROVIDER_URL!,
  europeanBaseUrl: process.env.EUROPEAN_PROVIDER_URL!,
  mongoUri:         process.env.MONGODB_URI!,
  port:             process.env.PORT || '3000',
}));
