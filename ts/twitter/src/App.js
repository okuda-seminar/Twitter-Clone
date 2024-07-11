import { HStack } from "@chakra-ui/react";
import "./App.css";
import SideBar from "./Features/Sidebar";
import Home from "./Features/Home";

function App() {
  return (
    <HStack>
      <SideBar />
      <Home />
    </HStack>
  );
}

export default App;
