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
      baseURL: "http://localhost:80",
      global: true,
    }),
    GraphQLModule.forRoot<ApolloDriverConfig>({
      driver: ApolloDriver,
      autoSchemaFile: join(process.cwd(), "src/schema.gql"),
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
