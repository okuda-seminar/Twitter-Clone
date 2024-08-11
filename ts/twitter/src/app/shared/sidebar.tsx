import React from "react";
import { IconButton, Tooltip, VStack, Button ,Flex, Box} from "@chakra-ui/react";
import { SearchIcon, BellIcon, EmailIcon, EditIcon } from "@chakra-ui/icons";
import { PiHouseFill } from "react-icons/pi";
import { FaUser } from "react-icons/fa";
import { BsSlashSquare, BsPeople } from "react-icons/bs";
import { CiCircleMore } from "react-icons/ci";
import { FaTwitter } from "react-icons/fa";
import Link from "next/link";

const SideBar: React.FC = () => {
  return (
    <VStack marginBottom="48px" align="flex-start">
       {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/389 - Create a reusable Sidebar component for the Link-Tooltip-IconButton structure */}
      <Link href="/home">
        <Tooltip label="twitter" placement="bottom" >
          <Flex alignItems="center">
            <IconButton aria-label="Twitter" borderRadius="full" icon={<FaTwitter />} mx={4}/>
          </Flex>
        </Tooltip>
      </Link>

      <Link href="/home">
        <Tooltip label="Home" placement="bottom">
        {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/392 - Implement conditional tooltips for sidebar icons based on window size */}
          <Flex alignItems="center">
            <IconButton aria-label="Home" icon={<PiHouseFill />} mx={4}/>
            <Box display={{ base: "none", xl: "inline" }}>
              <span className="font-bold">Home</span>
            </Box>
          </Flex>
        </Tooltip>
      </Link>

      <Link href="/explore">
        <Tooltip label="Explore" placement="bottom">
          <Flex alignItems="center">
            <IconButton aria-label="Explore" icon={<SearchIcon />} mx={4}/>
            <Box display={{ base: "none", xl: "inline" }}>
              <span className="font-bold">Explore</span>
            </Box>
          </Flex>
        </Tooltip> 
      </Link>

      <Link href="/notifications">
        <Tooltip label="Notifications" placement="bottom">
          <Flex alignItems="center">
            <IconButton aria-label="Notifications" icon={<BellIcon />} mx={4}/>
            <Box display={{ base: "none", xl: "inline" }}>
              <span className="font-bold">Notifications</span>
            </Box>
          </Flex>
        </Tooltip>
      </Link>

      <Link href="/message">
        <Tooltip label="Message" placement="bottom">
          <Flex alignItems="center">
            <IconButton aria-label="Message" icon={<EmailIcon />} mx={4}/>
            <Box display={{ base: "none", xl: "inline" }}>
              <span className="font-bold">Message</span>
            </Box>
          </Flex>
        </Tooltip>
      </Link>

      <Link href="/groc">
        <Tooltip label="Groc" placement="bottom">
         <Flex alignItems="center">
           <IconButton aria-label="Groc" icon={<BsSlashSquare />} mx={4}/>
           <Box display={{ base: "none", xl: "inline" }}>
              <span className="font-bold">Groc</span>
            </Box>
          </Flex>
        </Tooltip>
      </Link>

      <Link href="/comunity">
        <Tooltip label="Comunity" placement="bottom">
          <Flex alignItems="center">
            <IconButton aria-label="Comunity" icon={<BsPeople />} mx={4}/>
            <Box display={{ base: "none", xl: "inline" }}>
              <span className="font-bold">Comunity</span>
            </Box>
          </Flex>
        </Tooltip>
      </Link>

      <Link href="/profile">
        <Tooltip label="Profile" placement="bottom">
          <Flex alignItems="center">
            <IconButton aria-label="Profile" icon={<FaUser />} mx={4}/>
            <Box display={{ base: "none", xl: "inline" }}>
              <span className="font-bold">Profile</span>
            </Box>
          </Flex>
        </Tooltip>
      </Link>

      <Tooltip label="More" placement="bottom">
        <Flex alignItems="center">
          <IconButton aria-label="More" icon={<CiCircleMore />} mx={4}/>
          <Box display={{ base: "none", xl: "inline" }}>
            <span className="font-bold">More</span>
          </Box>
        </Flex>
      </Tooltip>

      <Box display={{ base: "none", xl: "inline" }}>
        <Button
          className="hover:brightness-95 transition-all duration-200"
          bg="blue.400"
          color="white"
          borderRadius="full"
          px={4}
          py={2}
          mt={4}
          w="48"
          h="9"
          boxShadow="md">
          Post
        </Button>  
      </Box>
      
    </VStack>
  );
};

export default SideBar;
