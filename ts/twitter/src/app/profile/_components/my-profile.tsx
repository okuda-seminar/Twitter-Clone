"use client";
import React, { useEffect, useState } from "react";
import {
  Box,
  VStack,
  Flex,
  Avatar,
  IconButton,
  Button,
  Divider,
  Tooltip,
  Text,
} from "@chakra-ui/react";
import {
  findUserById,
  FindUserByIdResponse,
} from "@/lib/actions/find-user-by-id";
import { ArrowBackIcon, CalendarIcon } from "@chakra-ui/icons";
import { MyProfileTab } from "./my-profile-tab";

enum ProfileFetchState {
  Loading,
  Error,
  Success,
}

export const MyProfile: React.FC = () => {
  const [userProfile, setUserProfile] = useState<FindUserByIdResponse | null>(
    null
  );
  const [error, setError] = useState<string | null>(null);
  const [joinDate, setJoinDate] = useState<string>("");
  const [fetchState, setFetchState] = useState<ProfileFetchState>(
    ProfileFetchState.Loading
  );
  const userPostCount: number = 0;
  const followingCount: number = 0;
  const followersCount: number = 0;

  useEffect(() => {
    const fetchUserProfile = async () => {
      try {
        setFetchState(ProfileFetchState.Loading);
        const res = await findUserById({
          user_id: `${process.env.NEXT_PUBLIC_USER_ID}`,
        });
        setUserProfile(res);
        const date = new Date(res.created_at);
        const formattedDate = new Intl.DateTimeFormat("en-US", {
          month: "long",
          year: "numeric",
        }).format(date);
        setJoinDate(formattedDate);
        setFetchState(ProfileFetchState.Success);
      } catch (err) {
        setError(
          err instanceof Error ? err.message : "Failed to fetch user profile"
        );
        setFetchState(ProfileFetchState.Error);
      }
    };

    fetchUserProfile();
  }, []);

  switch (fetchState) {
    case ProfileFetchState.Loading:
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/472 - Implement Loading and Error Pages for Data Fetching States.
      return <Text mx="4px">Loading...</Text>;
    case ProfileFetchState.Error:
      return <Text mx="4px">Error: {error}</Text>;
    case ProfileFetchState.Success:
      return (
        <VStack align="stretch">
          <Flex mx="4px" gap="4">
            <Tooltip label="Back" placement="bottom" fontSize="xs">
              <IconButton
                mt="5px"
                bg="transparent"
                borderRadius="full"
                aria-label="arrow"
                icon={<ArrowBackIcon />}
              />
            </Tooltip>
            <Box mt="5px">
              <Text fontSize="lg">{userProfile?.display_name}</Text>
              <Text fontSize="xs" color="gray">
                {userPostCount} post
              </Text>
            </Box>
          </Flex>
          <Divider />
          <Flex mx="8px">
            <Avatar size="xl" mx="8px" name={userProfile?.username}></Avatar>
            <Button borderRadius="full" marginLeft="auto">
              EditProfile
            </Button>
          </Flex>
          <Flex direction="column">
            <Box fontSize="2xl" mt="2px" mx="24px">
              {userProfile?.display_name}
            </Box>
            <Box fontSize="sm" color="gray" mx="24px">
              @{userProfile?.username}
            </Box>
          </Flex>
          <Flex alignItems="center" color="gray" mx="24px" gap="2">
            <CalendarIcon />
            <Box fontSize="sm">Joined {joinDate}</Box>
          </Flex>
          <Flex fontSize="sm" mx="24px" gap="4">
            <Flex gap="1">
              <Box>{followingCount}</Box>
              <Box color="gray">Following</Box>
            </Flex>
            <Flex gap="1">
              <Box>{followersCount}</Box>
              <Box color="gray">Followers</Box>
            </Flex>
          </Flex>
          <MyProfileTab />
        </VStack>
      );
  }
};
