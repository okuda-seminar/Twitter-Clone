import { Icon, type IconProps } from "@chakra-ui/react";

export const CalendarIcon = (props: IconProps) => {
  return (
    <Icon {...props}>
      <svg role="img" aria-label="Calendar" viewBox="0 0 24 24">
        <path
          fill="currentColor"
          d="M7 4V3h2v1h6V3h2v1h1.5C19.89 4 21 5.12 21 6.5v12c0 1.38-1.11 2.5-2.5 2.5h-13C4.12 21 3 19.88 3 18.5v-12C3 5.12 4.12 4 5.5 4H7zm0 2H5.5c-.27 0-.5.22-.5.5v12c0 .28.23.5.5.5h13c.28 0 .5-.22.5-.5v-12c0-.28-.22-.5-.5-.5H17v1h-2V6H9v1H7V6zm0 6h2v-2H7v2zm0 4h2v-2H7v2zm4-4h2v-2h-2v2zm0 4h2v-2h-2v2zm4-4h2v-2h-2v2z"
        />
      </svg>
    </Icon>
  );
};
