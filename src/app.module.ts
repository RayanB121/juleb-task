import { Module } from '@nestjs/common';
import { ServeStaticModule } from '@nestjs/serve-static';
const path = require("path")

@Module({
  imports: [
    ServeStaticModule.forRoot({
      rootPath: path.resolve("build")}),
  ],
})
export class AppModule {}
