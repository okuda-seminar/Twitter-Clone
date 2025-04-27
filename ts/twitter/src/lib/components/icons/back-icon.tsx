import { Icon, type IconProps } from "@chakra-ui/react";

export const BackIcon = (props: IconProps) => {
  return (
    <Icon {...props}>
      <svg role="img" aria-label="Back" viewBox="0 0 24 24">
        <path
          fill="currentColor"
          d="M7.414 13l5.043 5.04-1.414 1.42L3.586 12l7.457-7.46 1.414 1.42L7.414 11H21v2H7.414z"
        />
      </svg>
    </Icon>
  );
};
