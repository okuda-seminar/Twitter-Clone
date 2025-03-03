import amqp from "amqplib";
import { RabbitMqLogger } from "../rabbitmq-logger";

vi.mock("amqplib");

describe("RabbitMqLogger", () => {
  let logger: RabbitMqLogger;
  let connectMock: ReturnType<typeof vi.fn>;
  let createChannelMock: ReturnType<typeof vi.fn>;
  let assertQueueMock: ReturnType<typeof vi.fn>;
  let sendToQueueMock: ReturnType<typeof vi.fn>;
  let getMock: ReturnType<typeof vi.fn>;
  let closeMock: ReturnType<typeof vi.fn>;

  beforeAll(() => {
    process.env.NEXT_PUBLIC_RABBITMQ_URL = "amqp://mock-rabbitmq";
  });

  beforeEach(() => {
    sendToQueueMock = vi.fn();
    assertQueueMock = vi.fn();
    getMock = vi.fn().mockResolvedValue({
      content: Buffer.from(
        JSON.stringify({
          eventType: "interaction",
          objectId: "12345",
          createdAt: new Date(),
        }),
      ),
    });
    closeMock = vi.fn();

    createChannelMock = vi.fn().mockResolvedValue({
      assertQueue: assertQueueMock,
      sendToQueue: sendToQueueMock,
      get: getMock,
      close: closeMock,
    });

    connectMock = vi.fn().mockResolvedValue({
      createChannel: createChannelMock,
      close: closeMock,
    });

    (amqp.connect as ReturnType<typeof vi.fn>).mockImplementation(connectMock);

    logger = new RabbitMqLogger();
  });

  afterEach(() => {
    vi.clearAllMocks();
  });

  it("should send a interaction log to the logs queue", async () => {
    const objectId = "98765";

    await expect(logger.sendInteractionLog(objectId)).resolves.not.toThrow();
    expect(sendToQueueMock).toHaveBeenCalledWith(
      expect.any(String),
      expect.any(Buffer),
      { persistent: true },
    );
  });

  it("should send an impression log to the logs queue", async () => {
    const objectId = "54321";

    await expect(logger.sendImpressionLog(objectId)).resolves.not.toThrow();
    expect(sendToQueueMock).toHaveBeenCalledWith(
      expect.any(String),
      expect.any(Buffer),
      { persistent: true },
    );
  });

  it("should send multiple logs independently", async () => {
    await expect(logger.sendInteractionLog("12345")).resolves.not.toThrow();
    await expect(logger.sendImpressionLog("23456")).resolves.not.toThrow();

    expect(sendToQueueMock).toHaveBeenCalledTimes(2);
  });

  it("should verify the latest message in logs queue", async () => {
    const message = await getMock();
    expect(message).not.toBeNull();

    if (message) {
      const content = JSON.parse(message.content.toString());

      expect(content).toHaveProperty("eventType");
      expect(content).toHaveProperty("objectId");
      expect(content).toHaveProperty("createdAt");
      expect(typeof content.createdAt).toBe("string");
    }
  });

  it("should throw an error if RabbitMQ is unreachable", async () => {
    (amqp.connect as ReturnType<typeof vi.fn>).mockRejectedValue(
      new Error("Connection failed"),
    );

    const errorLogger = new RabbitMqLogger();
    await expect(errorLogger.sendInteractionLog("12345")).rejects.toThrow(
      "Connection failed",
    );
  });
});
