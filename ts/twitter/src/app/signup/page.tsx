import { cookies } from "next/headers";
import { Home } from "../home/_components/home";
import { SignupModal } from "./_components/signup-modal";

export default async function Page() {
  const cookieStore = await cookies();
  const authToken = cookieStore.get("auth_token");

  if (authToken) {
    return <Home />;
  }

  return <SignupModal />;
}
