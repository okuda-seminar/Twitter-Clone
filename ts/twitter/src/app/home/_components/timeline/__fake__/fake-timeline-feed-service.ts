import type {
  TimelineEventResponse,
  TimelineFeedService,
} from "../timeline-feed-service";

export class FakeTimelineFeedService implements TimelineFeedService {
  private handleResponse: ((response: TimelineEventResponse) => void) | null =
    null;
  private handleError: ((message: string) => void) | null = null;

  connect(
    url: string,
    handleResponse: (response: TimelineEventResponse) => void,
    handleError: (message: string) => void,
  ): void {
    this.handleResponse = handleResponse;
    this.handleError = handleError;
  }

  disconnect(): void {
    this.handleResponse = null;
    this.handleError = null;
  }

  simulateMessage(response: TimelineEventResponse): void {
    if (!this.handleResponse) {
      throw new Error("Not connected");
    }
    this.handleResponse(response);
  }

  simulateError(message: string): void {
    if (!this.handleError) {
      throw new Error("Not connected");
    }
    this.handleError(message);
  }
}
