import amqp from "amqplib";
import { RabbitMqLogger } from "../rabbitmq-logger";

jest.mock("amqplib");

describe("RabbitMqLogger", () => {
  let logger: RabbitMqLogger;
  let connectMock: jest.Mock;
  let createChannelMock: jest.Mock;
  let assertQueueMock: jest.Mock;
  let sendToQueueMock: jest.Mock;
  let getMock: jest.Mock;
  let closeMock: jest.Mock;

  beforeAll(() => {
    process.env.NEXT_PUBLIC_RABBITMQ_URL = "amqp://mock-rabbitmq";
  });

  beforeEach(() => {
    sendToQueueMock = jest.fn();
    assertQueueMock = jest.fn();
    getMock = jest.fn().mockResolvedValue({
      content: Buffer.from(
        JSON.stringify({
          eventType: "interaction",
          objectId: "12345",
          createdAt: new Date(),
        }),
      ),
    });
    closeMock = jest.fn();

    createChannelMock = jest.fn().mockResolvedValue({
      assertQueue: assertQueueMock,
      sendToQueue: sendToQueueMock,
      get: getMock,
      close: closeMock,
    });

    connectMock = jest.fn().mockResolvedValue({
      createChannel: createChannelMock,
      close: closeMock,
    });

    (amqp.connect as jest.Mock).mockImplementation(connectMock);

    logger = new RabbitMqLogger();
  });

  afterEach(() => {
    jest.clearAllMocks();
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
    (amqp.connect as jest.Mock).mockRejectedValue(
      new Error("Connection failed"),
    );

    const errorLogger = new RabbitMqLogger();
    await expect(errorLogger.sendInteractionLog("12345")).rejects.toThrow(
      "Connection failed",
    );
  });
});
