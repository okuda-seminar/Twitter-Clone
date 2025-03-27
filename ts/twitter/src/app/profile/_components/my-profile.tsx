import type { FindUserByIdResponse } from "@/lib/actions/find-user-by-id";
import { useColorModeValue } from "@/lib/components/ui/color-mode";
import { Tooltip } from "@/lib/components/ui/tooltip";
import {
  Avatar,
  Box,
  Button,
  Flex,
  IconButton,
  Text,
  VStack,
} from "@chakra-ui/react";
import type React from "react";
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
      <Box divideY="1px">
        <Box>
          <Flex mx="4px" gap="4">
            <Tooltip content="Back" positioning={{ placement: "bottom" }}>
              <IconButton
                mt="5px"
                bg="transparent"
                borderRadius="full"
                aria-label="arrow"
                color={useColorModeValue("black", "white")}
              >
                <GoArrowLeft />
              </IconButton>
            </Tooltip>
            <Box mt="5px">
              <Text fontSize="lg">{userProfile.display_name}</Text>
              <Text fontSize="xs" color="gray">
                {userPostCount} post
              </Text>
            </Box>
          </Flex>
        </Box>
        <Box>
          <Flex mx="8px" my="8px">
            <Avatar.Root w="96px" h="96px">
              <Avatar.Fallback
                name={userProfile.username}
                mx="8px"
                fontSize="36px"
              />
              <Avatar.Image />
            </Avatar.Root>
            <Button
              borderRadius="full"
              marginLeft="auto"
              bg="gray.200"
              color="black"
              fontSize="md"
              _hover={{ bg: "gray.300" }}
            >
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
        </Box>
      </Box>

      <MyProfileTab />
    </VStack>
  );
};
