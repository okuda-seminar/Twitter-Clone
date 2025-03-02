import { render } from "@testing-library/react";
import { Notifications } from "../_components/notifications";

describe("Notifications Tests", () => {
  it("should successfully render Notifications", () => {
    render(<Notifications />);
  });
});
