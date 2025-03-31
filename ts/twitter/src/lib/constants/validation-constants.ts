export const VALIDATION_CONSTANTS = {
  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/652
  // - Update CreateUserRequest schema to match users table username constraints.
  USERNAME: {
    MIN_LENGTH: 4,
    MAX_LENGTH: 14,
  },
  PASSWORD: {
    MIN_LENGTH: 8,
    MAX_LENGTH: 15,
  },
};
