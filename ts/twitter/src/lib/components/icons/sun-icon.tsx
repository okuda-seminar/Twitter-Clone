import { Icon, type IconProps } from "@chakra-ui/react";

export const SunIcon = (props: IconProps) => {
  return (
    <Icon {...props}>
      <svg
        role="img"
        aria-label="Sun"
        viewBox="0 0 24 24"
        stroke="currentcolor"
      >
        <circle cx="12" cy="12" r="4" />
        <path d="M12 2v2" />
        <path d="M12 20v2" />
        <path d="m4.93 4.93 1.41 1.41" />
        <path d="m17.66 17.66 1.41 1.41" />
        <path d="M2 12h2" />
        <path d="M20 12h2" />
        <path d="m6.34 17.66-1.41 1.41" />
        <path d="m19.07 4.93-1.41 1.41" />
      </svg>
    </Icon>
  );
};
