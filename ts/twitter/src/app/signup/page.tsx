import { cookies } from "next/headers";
import { Home } from "../home/_components/home";
import { SignupModal } from "./_components/signup-modal";

export default function Page() {
  const cookieStore = cookies();
  const authToken = cookieStore.get("auth_token");

  if (authToken) {
    return <Home />;
  }

  return <SignupModal />;
}
