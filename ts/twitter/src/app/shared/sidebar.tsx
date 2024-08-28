import React from "react";
import { IconButton, Tooltip, VStack, Flex, Box, Text } from "@chakra-ui/react";
import { SearchIcon, BellIcon, EmailIcon } from "@chakra-ui/icons";
import { PiHouseFill } from "react-icons/pi";
import { FaUser } from "react-icons/fa";
import { BsSlashSquare, BsPeople } from "react-icons/bs";
import { CiCircleMore } from "react-icons/ci";
import { FaTwitter } from "react-icons/fa";
import Link from "next/link";
import IconButtonWithLink from "./iconbuttonwithlink";
import Posts from "../posts/page";

const SideBar: React.FC = () => {
  return (
    <VStack marginBottom="48px" align="flex-start">
      <Link href="/home">
        <Tooltip label="twitter" placement="bottom" >
          <Flex alignItems="center">
            <IconButton aria-label="Twitter" borderRadius="full" icon={<FaTwitter />} mx={4}/>
          </Flex>
        </Tooltip>
      </Link>

      <IconButtonWithLink 
        url={"/home"} 
        tooltipText={"Home"} 
        ariaLabel={"Home"}
        icon={<PiHouseFill />}/>

      <IconButtonWithLink 
        url={"/explore"} 
        tooltipText={"Explore"} 
        ariaLabel={"Explore"}
        icon={<SearchIcon />}/>

      <IconButtonWithLink 
        url={"/notifications"} 
        tooltipText={"Notifications"} 
        ariaLabel={"Notifications"}
        icon={<BellIcon />}/>

      <IconButtonWithLink 
        url={"/message"} 
        tooltipText={"Message"} 
        ariaLabel={"Message"}
        icon={<EmailIcon />}/>

      <IconButtonWithLink 
        url={"/groc"} 
        tooltipText={"Groc"} 
        ariaLabel={"Groc"}
        icon={<BsSlashSquare />}/>

      <IconButtonWithLink 
        url={"/community"} 
        tooltipText={"Community"} 
        ariaLabel={"Community"}
        icon={<BsPeople />}/>

      <IconButtonWithLink 
        url={"/profile"} 
        tooltipText={"Profile"} 
        ariaLabel={"Profile"}
        icon={<FaUser />}/>

      <Tooltip label="More" placement="bottom">
        <Flex alignItems="center">
          <IconButton aria-label="More" icon={<CiCircleMore />} mx={4}/>
          <Box display={{ base: "none", xl: "inline" }}>
          <Text fontWeight="bold">More</Text>
          </Box>
        </Flex>
      </Tooltip>
      
      <Posts/>
      
    </VStack>
  );
};

export default SideBar;
