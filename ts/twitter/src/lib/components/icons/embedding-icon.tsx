import { Icon, type IconProps } from "@chakra-ui/react";

export const EmbeddingIcon = (props: IconProps) => {
  return (
    <Icon {...props}>
      <svg role="img" aria-label="Embedding" viewBox="0 0 24 24">
        <path
          fill="currentColor"
          d="M15.24 4.31l-4.55 15.93-1.93-.55 4.55-15.93 1.93.55zm-8.33 3.6L3.33 12l3.58 4.09-1.5 1.32L.67 12l4.74-5.41 1.5 1.32zm11.68-1.32L23.33 12l-4.74 5.41-1.5-1.32L20.67 12l-3.58-4.09 1.5-1.32z"
        />
      </svg>
    </Icon>
  );
};
