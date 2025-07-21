import { Icon, type IconProps } from "@chakra-ui/react";

export const AnalyticsIcon = (props: IconProps) => {
  return (
    <Icon {...props}>
      <svg role="img" aria-label="Analytics" viewBox="0 0 24 24">
        <g>
          <path
            fill="currentColor"
            d="M8.75 21V3h2v18h-2zM18 21V8.5h2V21h-2zM4 21l.004-10h2L6 21H4zm9.248 0v-7h2v7h-2z"
          />
        </g>
      </svg>
    </Icon>
  );
};
