export const ERROR_MESSAGES = {
  SERVER_ERROR: "A server error occurred.",
  INVALID_DATA: "Invalid data received.",
  CONNECTION_ERROR: "Connection error occurred.",
  POST_CREATION_ERROR:
    "Something went wrong, but don't fret - let's give it another shot.",
  SIGNUP_ERROR: "Something went wrong with signup. Please try again.",
  UNKNOWN_ERROR: "An unknown error occurred.",
  NO_AUTH_TOKEN: "No authentication token found.",
} as const;

export const STATUS_TEXT = {
  INTERNAL_SERVER_ERROR: "Internal Server Error",
} as const;
