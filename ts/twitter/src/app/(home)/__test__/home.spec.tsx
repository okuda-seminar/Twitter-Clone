import { render, waitFor } from "@testing-library/react";
import { Home } from "../_components/home";
import { SessionProvider } from "@/lib/compoenents/session-context";
import axios from "axios";

jest.mock("next/navigation", () => ({
  useRouter() {
    return {
      push: jest.fn(),
    };
  },
}));

jest.mock("axios");

describe("Home Tests", () => {
  beforeEach(() => {
    (axios as jest.Mocked<typeof axios>).get.mockResolvedValue({
      data: {
        id: "1",
        user_id: "1",
        text: "test post",
      },
    });
  });

  test("Rendering Home component without Post Modal should success", () => {
    waitFor(() => {
      render(<Home isPostModalOpen={false} />, { wrapper: SessionProvider });
    });
  });

  test("Rendering Home component with Post Modal open should success", () => {
    waitFor(() => {
      render(<Home isPostModalOpen={true} />, { wrapper: SessionProvider });
    });
  });
});
