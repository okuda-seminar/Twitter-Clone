interface Ok<T> {
  ok: true;
  value: T;
}

interface Err<E> {
  ok: false;
  error: E;
}

export const ok = <T>(value: T): Ok<T> => ({ ok: true, value });

export const err = <E>(error: E): Err<E> => ({ ok: false, error });

export interface ServerActionsError {
  status: number;
  statusText: string;
}

export type ServerActionsResult<T, E extends ServerActionsError> =
  | Ok<T>
  | Err<E>;
