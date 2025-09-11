# Use the official Redis image as base
FROM redis:7.2-alpine

# Optional: Set a working directory (not required for Redis)
WORKDIR /data

# Optional: Copy a custom Redis configuration file (if you have one)
# COPY redis.conf /usr/local/etc/redis/redis.conf

# Optional: Use the custom configuration when starting Redis
# CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]

# Default command starts Redis with default config
CMD ["redis-server"]
