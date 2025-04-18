import { Module } from "@nestjs/common";
import { TimelineResolver } from "./timeline.resolver";
import { TimelineService } from "./timeline.service";

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/688
// - Write unit tests for TimelineResolver and TimelineService.
@Module({
  providers: [TimelineService, TimelineResolver],
})
export class TimelineModule {}
