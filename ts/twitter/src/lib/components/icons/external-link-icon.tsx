import { Icon, type IconProps } from "@chakra-ui/react";

export const ExternalLinkIcon = (props: IconProps) => {
  return (
    <Icon {...props}>
      <svg role="img" aria-label="ChevronRight" viewBox="0 0 24 24">
        <path
          fill="currentColor"
          d="M8 6h10v10h-2V9.41L5.957 19.46l-1.414-1.42L14.586 8H8V6z"
        />
      </svg>
    </Icon>
  );
};
