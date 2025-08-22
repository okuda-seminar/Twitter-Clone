export interface Hashtags {
  id: string;
  text: string;
  category: string;
  postCount: number;
}

export const dummyHashtags: Hashtags[] = [
  {
    id: "1",
    text: "#DeltaForceCSVersionLaunch",
    category: "Gaming",
    postCount: 2500,
  },
  {
    id: "2",
    text: "#HappyRANDay2025",
    category: "Only on X",
    postCount: 3439,
  },
  {
    id: "3",
    text: "#TaylorSwift",
    category: "Music",
    postCount: 1819,
  },
  {
    id: "4",
    text: "#VocaloidSummer2025TOP100",
    category: "Trending in Japan",
    postCount: 15000,
  },
];
