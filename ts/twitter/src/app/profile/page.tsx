import { findUserById } from "@/lib/actions/find-user-by-id";
import { Box } from "@chakra-ui/react";
import { MyProfile } from "./_components/my-profile";

export default async function Page() {
  const res = await findUserById({
    user_id: `${process.env.NEXT_PUBLIC_USER_ID}`,
  });

  if (res.ok) {
    return <MyProfile userProfile={res.value} />;
  }

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/514
  // - Display a dedicated error page if user lookup fails.
  return <Box>{res.error.statusText}</Box>;
}
