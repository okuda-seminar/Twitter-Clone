import { render } from "@testing-library/react";
import { Notifications } from "../_components/notifications";

describe("Notifications Tests", () => {
  test("Rendering Notifications should succeed", () => {
    render(<Notifications />);
  });
});
