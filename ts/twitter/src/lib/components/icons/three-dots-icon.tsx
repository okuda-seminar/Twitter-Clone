import { Icon, type IconProps } from "@chakra-ui/react";

export const ThreeDotsIcon = (props: IconProps) => {
  return (
    <Icon {...props}>
      <svg role="img" aria-label="ThreeDots" viewBox="0 0 24 24">
        <path
          fill="currentColor"
          d="M4.5 12a1.5 1.5 0 113 0 1.5 1.5 0 01-3 0zm7.5 0a1.5 1.5 0 113 0 1.5 1.5 0 01-3 0zm7.5 0a1.5 1.5 0 113 0 1.5 1.5 0 01-3 0z"
        />
      </svg>
    </Icon>
  );
};
