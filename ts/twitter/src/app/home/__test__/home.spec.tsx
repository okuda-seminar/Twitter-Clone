import { render } from "@testing-library/react";

import Home from "../home";

describe("Home Tests", () => {
  test("Rendering should success", () => {
    render(<Home />);
  });
});
