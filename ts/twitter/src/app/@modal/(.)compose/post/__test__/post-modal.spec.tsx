import { render, screen } from "@testing-library/react";
import { PostModal } from "../_components/post-modal/post-modal";
import { SessionProvider } from "@/lib/components/session-context";

jest.mock("next/navigation", () => ({
  useRouter() {
    return jest.fn();
  },
}));

jest.mock("react-dom", () => {
  return {
    ...jest.requireActual("react-dom"),
    useFormState: () => ["message", jest.fn()],
    useFormStatus: () => ({
      pending: true,
    }),
  };
});

describe("Post Modal Tests", () => {
  test("Rendering intercepted Post Modal should succeed", () => {
    render(<PostModal isIntercepted={true} />, { wrapper: SessionProvider });
  });

  test("Rendering non-intercepted Post Modal should succeed", () => {
    render(<PostModal isIntercepted={false} />, { wrapper: SessionProvider });
  });

  test("Error message should be displayed when the form action fails", () => {
    render(<PostModal isIntercepted={true} />, { wrapper: SessionProvider });
    const errorMessage = screen.getByText("message");
    expect(errorMessage).toBeInTheDocument();
  });
});
