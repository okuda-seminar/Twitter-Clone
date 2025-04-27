import { Icon, type IconProps } from "@chakra-ui/react";

export const MoonIcon = (props: IconProps) => {
  return (
    <Icon {...props}>
      <svg role="img" aria-label="Moon" viewBox="0 0 24 24">
        <path fill="currentColor" d="M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z" />,
      </svg>
    </Icon>
  );
};
