// pages/index.js
import { Heading, Box } from '@chakra-ui/react';

export default function Home() {
  return (
    <Box p={4}>
      <Heading as="h1" size="xl">
        Welcome to My Next.js App with Chakra UI!
      </Heading>
      <Box mt={4}>
        <p>This is a simple Next.js app with Chakra UI components.</p>
      </Box>
    </Box>
  );
}
