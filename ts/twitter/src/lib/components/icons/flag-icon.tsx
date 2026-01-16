import { Icon, type IconProps } from "@chakra-ui/react";

export const FlagIcon = (props: IconProps) => {
  return (
    <Icon {...props}>
      <svg role="img" aria-label="FlagIcon" viewBox="0 0 24 24">
        <path
          fill="currentColor"
          d="M3 2h18.61l-3.5 7 3.5 7H5v6H3V2zm2 12h13.38l-2.5-5 2.5-5H5v10z"
        />
      </svg>
    </Icon>
  );
};
