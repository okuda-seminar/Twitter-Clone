import { render } from "@testing-library/react";
import { PostModal } from "../_components/post-modal/post-modal";
import { SessionProvider } from "@/lib/components/session-context";

jest.mock("next/navigation", () => ({
  useRouter() {
    return jest.fn();
  },
}));

describe("Post Modal Tests", () => {
  test("Rendering intercepted Post Modal should success", () => {
    render(<PostModal isIntercepted={true} />, { wrapper: SessionProvider });
  });

  test("Rendering non-intercepted Post Modal should success", () => {
    render(<PostModal isIntercepted={false} />, { wrapper: SessionProvider });
  });
});
