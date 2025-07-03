import { Icon, type IconProps } from "@chakra-ui/react";

export const ChevronRightIcon = (props: IconProps) => {
  return (
    <Icon {...props}>
      <svg role="img" aria-label="ChevronRight" viewBox="0 0 24 24">
        <path
          fill="currentColor"
          d="M14.586 12L7.543 4.96l1.414-1.42L17.414 12l-8.457 8.46-1.414-1.42L14.586 12z"
        />
      </svg>
    </Icon>
  );
};
