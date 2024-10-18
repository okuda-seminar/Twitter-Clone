import { render } from "@testing-library/react";
import { Home } from "../_components/home";

describe("Home Tests", () => {
  test("Rendering should success", () => {
    render(<Home />);
  });
});
