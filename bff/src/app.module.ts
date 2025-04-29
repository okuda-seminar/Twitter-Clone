import { join } from "node:path";
import { ApolloServerPluginLandingPageLocalDefault } from "@apollo/server/plugin/landingPage/default";
import { ApolloDriver, ApolloDriverConfig } from "@nestjs/apollo";
import { HttpModule } from "@nestjs/axios";
import { Module } from "@nestjs/common";
import { GraphQLModule } from "@nestjs/graphql";
import { AppController } from "./app.controller";
import { AppService } from "./app.service";
import { TimelineModule } from "./timeline/timeline.module";

@Module({
  imports: [
    HttpModule.register({
      baseURL: process.env.API_BASE_URL,
      global: true,
    }),
    GraphQLModule.forRoot<ApolloDriverConfig>({
      driver: ApolloDriver,
      autoSchemaFile:
        process.env.STAGE === "dev"
          ? join(process.cwd(), "src/schema.gql")
          : true,
      buildSchemaOptions: {
        addNewlineAtEnd: true,
      },
      playground: false,
      // use Apollo Sandbox instead of the graphql-playground.
      plugins: [ApolloServerPluginLandingPageLocalDefault()],
    }),
    TimelineModule,
  ],
  controllers: [AppController],
  providers: [AppService],
  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/687
  // - Implement and register a global GraphQL exception filter.
})
export class AppModule {}
