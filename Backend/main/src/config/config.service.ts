import { Logger } from '@nestjs/common';
import * as dotenv from 'dotenv';
import * as fs from 'fs';

export const enum ConfigKey {
  MONGODB_URL = 'MONGODB_URL',
}

export class ConfigService {
  private readonly logger = new Logger('ConfigService');
  private readonly envConfig: Record<keyof ConfigKey, string>;

  constructor(filePath: string) {
    this.envConfig = dotenv.parse(fs.readFileSync(filePath)) as Record<keyof ConfigKey, string>;
    const stringify = JSON.stringify(this.envConfig);
    this.logger.log(`Load config: ${stringify}`)
  }

  get(key: ConfigKey): string {
    return this.envConfig[key];
  }
}