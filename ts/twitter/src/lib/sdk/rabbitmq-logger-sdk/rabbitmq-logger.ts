import amqp from "amqplib";

export class RabbitMqLogger {
  private static readonly QUEUE_NAME = "logs";
  async sendLog(eventName: string, objectId: string): Promise<void> {
    let connection: amqp.Connection | undefined = undefined;
    let channel: amqp.Channel | undefined = undefined;

    try {
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/557
      // - Discuss how we send log while reducing the number of connections and channels.

      const rabbitMqUrl = process.env.NEXT_PUBLIC_RABBITMQ_URL;
      if (!rabbitMqUrl) {
        throw new Error("RABBITMQ_URL is not set in environment variables");
      }

      connection = await amqp.connect(rabbitMqUrl);
      channel = await connection.createChannel();
      await channel.assertQueue(RabbitMqLogger.QUEUE_NAME, { durable: true });

      const logMessage = {
        eventType: eventName,
        objectId,
        createdAt: new Date(),
      };

      channel.sendToQueue(
        RabbitMqLogger.QUEUE_NAME,
        Buffer.from(JSON.stringify(logMessage)),
        { persistent: true },
      );
      console.log(`Log sent: ${JSON.stringify(logMessage)}`);
    } catch (error) {
      console.error("Failed to send log:", error);
      throw error;
    } finally {
      if (channel) await channel.close();
      if (connection) await connection.close();
    }
  }
}
