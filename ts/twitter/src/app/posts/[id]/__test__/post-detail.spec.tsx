import { fireEvent, render, screen } from "@testing-library/react";
import { PostDetail } from "../_components/post-detail";

describe("Post Detail Tests", () => {
  it("should successfully render PostDetail", () => {
    render(<PostDetail />);
  });

  it(`should display "Follow" button in initial render`, () => {
    render(<PostDetail />);
    const followButton = screen.getByRole("button", { name: "Follow" });
    expect(followButton).toBeInTheDocument();
  });

  it(`should change the button text to "Following" after clicking "Follow" button`, () => {
    render(<PostDetail />);
    const followButton = screen.getByRole("button");

    fireEvent.click(followButton);
    expect(
      screen.getByRole("button", { name: "Following" }),
    ).toBeInTheDocument();
  });

  it(`should change the button text to "Follow" after clicking "Following" button`, () => {
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
