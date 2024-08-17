import React from "react";
import { IconButton, Tooltip, VStack, Button ,Flex, Box} from "@chakra-ui/react";
import { SearchIcon, BellIcon, EmailIcon, EditIcon } from "@chakra-ui/icons";
import { PiHouseFill } from "react-icons/pi";
import { FaUser } from "react-icons/fa";
import { BsSlashSquare, BsPeople, BsLayersHalf } from "react-icons/bs";
import { CiCircleMore } from "react-icons/ci";
import { FaTwitter } from "react-icons/fa";
import Link from "next/link";
import IconButtonWithLink from "./CustomIconLink";

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
