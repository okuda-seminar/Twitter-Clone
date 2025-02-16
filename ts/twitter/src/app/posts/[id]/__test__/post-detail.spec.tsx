import { fireEvent, render, screen } from "@testing-library/react";
import { PostDetail } from "../_components/post-detail";

describe("Post Detail Tests", () => {
  test("Rendering PostDetail should succeed", () => {
    render(<PostDetail />);
  });

  test(`"Follow" button displays in initial render`, () => {
    render(<PostDetail />);
    const followButton = screen.getByRole("button", { name: "Follow" });
    expect(followButton).toBeInTheDocument();
  });

  test(`Button text changes to "Following" after clicking "Follow" button`, () => {
    render(<PostDetail />);
    const followButton = screen.getByRole("button");

    fireEvent.click(followButton);
    expect(
      screen.getByRole("button", { name: "Following" }),
    ).toBeInTheDocument();
  });

  test(`Button text changes to "Follow" after clicking "Following" button`, () => {
    render(<PostDetail />);
    const followButton = screen.getByRole("button");

    fireEvent.click(followButton);
    expect(
      screen.getByRole("button", { name: "Following" }),
    ).toBeInTheDocument();

    fireEvent.click(followButton);
    expect(screen.getByRole("button", { name: "Follow" })).toBeInTheDocument();
  });
});
