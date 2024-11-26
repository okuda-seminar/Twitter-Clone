import React from "react";
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
import { FindUserByIdResponse } from "@/lib/actions/find-user-by-id";
import { GoArrowLeft } from "react-icons/go";
import { RxCalendar } from "react-icons/rx";
import { MyProfileTab } from "./my-profile-tab";

interface MyProfileProps {
  userProfile: FindUserByIdResponse;
}

export const MyProfile: React.FC<MyProfileProps> = ({ userProfile }) => {
  const userPostCount: number = 0;
  const followingCount: number = 0;
  const followersCount: number = 0;

  const date = new Date(userProfile.created_at);
  const userJoinedDate = new Intl.DateTimeFormat("en-US", {
    month: "long",
    year: "numeric",
  }).format(date);

  return (
    <VStack align="stretch">
      <Flex mx="4px" gap="4">
        <Tooltip label="Back" placement="bottom" fontSize="xs">
          <IconButton
            mt="5px"
            bg="transparent"
            borderRadius="full"
            aria-label="arrow"
            icon={<GoArrowLeft />}
          />
        </Tooltip>
        <Box mt="5px">
          <Text fontSize="lg">{userProfile.display_name}</Text>
          <Text fontSize="xs" color="gray">
            {userPostCount} post
          </Text>
        </Box>
      </Flex>
      <Divider />
      <Flex mx="8px">
        <Avatar size="xl" mx="8px" name={userProfile.username}></Avatar>
        <Button borderRadius="full" marginLeft="auto">
          EditProfile
        </Button>
      </Flex>
      <Flex direction="column">
        <Box fontSize="2xl" mt="2px" mx="24px">
          {userProfile.display_name}
        </Box>
        <Box fontSize="sm" color="gray" mx="24px">
          @{userProfile.username}
        </Box>
      </Flex>
      <Flex alignItems="center" color="gray" mx="24px" gap="2">
        <RxCalendar />
        <Box fontSize="sm">Joined {userJoinedDate}</Box>
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
};
