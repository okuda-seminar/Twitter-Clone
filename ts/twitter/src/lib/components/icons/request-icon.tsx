import { Icon, type IconProps } from "@chakra-ui/react";

export const RequestIcon = (props: IconProps) => {
  return (
    <Icon {...props}>
      <svg role="img" aria-label="Request" viewBox="0 0 24 24">
        <path
          fill="currentColor"
          d="M22 2.63v17.74l-7.05-2.27c-.29 1.65-1.72 2.9-3.45 2.9C9.57 21 8 19.43 8 17.5v-1.63l-1.15-.37H4.5C3.12 15.5 2 14.38 2 13v-3c0-1.38 1.12-2.5 2.5-2.5h2.35L22 2.63zM6 9.5H4.5c-.27 0-.5.22-.5.5v3c0 .28.23.5.5.5H6v-4zm2 4.27l12 3.86V5.37L8 9.23v4.54zm2 2.74v.99c0 .83.67 1.5 1.5 1.5s1.5-.67 1.5-1.5v-.02l-3-.97z"
        />
      </svg>
    </Icon>
  );
};
