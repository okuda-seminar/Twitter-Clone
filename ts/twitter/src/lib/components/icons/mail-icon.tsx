import { Icon, type IconProps } from "@chakra-ui/react";

export const MailIcon = (props: IconProps) => {
  return (
    <Icon {...props}>
      <svg role="img" aria-label="Mail" viewBox="0 0 24 24">
        <path
          fill="currentColor"
          d="M1.998 5.5c0-1.381 1.119-2.5 2.5-2.5h15c1.381 0 2.5 1.119 2.5 2.5v13c0 1.381-1.119 2.5-2.5 2.5h-15c-1.381 0-2.5-1.119-2.5-2.5v-13zm2.5-.5c-.276 0-.5.224-.5.5v2.764l8 3.638 8-3.636V5.5c0-.276-.224-.5-.5-.5h-15zm15.5 5.463l-8 3.636-8-3.638V18.5c0 .276.224.5.5.5h15c.276 0 .5-.224.5-.5v-8.037z"
        />
      </svg>
    </Icon>
  );
};
