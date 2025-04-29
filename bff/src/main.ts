import * as dotenv from "dotenv";
dotenv.config();

import serverlessExpress from "@codegenie/serverless-express";
import { NestFactory } from "@nestjs/core";
import { APIGatewayProxyEvent, Callback, Context, Handler } from "aws-lambda";
import { AppModule } from "./app.module";

let server: Handler;

async function bootstrap(): Promise<Handler> {
  const app = await NestFactory.create(AppModule);
  await app.init();

  const expressApp = app.getHttpAdapter().getInstance();
  return serverlessExpress({ app: expressApp });
}

export const handler: Handler = async (
  event: APIGatewayProxyEvent,
  context: Context,
  callback: Callback,
) => {
  if (event.path === "" || event.path === undefined) event.path = "/";
  if (!server) {
    server = await bootstrap();
  }
  return server(event, context, callback);
};
