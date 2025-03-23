"use client";

import { findUserById } from "@/lib/actions/find-user-by-id";
import type { FindUserByIdResponse } from "@/lib/actions/find-user-by-id";
import { useSession } from "@/lib/components/session-context";
import { Box } from "@chakra-ui/react";
import { useEffect, useState } from "react";
import { MyProfile } from "./my-profile";

export const ProfileClient: React.FC = () => {
  const { user } = useSession();
  const [result, setResult] = useState<{
    userProfile?: FindUserByIdResponse;
    error?: { statusText: string };
  }>({});

  useEffect(() => {
    if (!user) return;

    findUserById({
      user_id: user.id,
    }).then((res) => {
      if (res.ok) {
        setResult({ userProfile: res.value });
      } else {
        setResult({ error: res.error });
      }
    });
  }, [user]);

  if (!user) {
    return <Box>User not logged in</Box>;
  }

  if (result.userProfile) {
    return <MyProfile userProfile={result.userProfile} />;
  }

  if (result.error) {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/514
    // - Display a dedicated error page if user lookup fails.
    return <Box>{result.error.statusText}</Box>;
  }
};
