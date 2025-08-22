export interface News {
  id: string;
  title: string;
  category: string;
  postCount: number;
}

export const dummyNews: News[] = [
  {
    id: "1",
    title: "Arsenal Snatch Eberechi Eze in £67.5M Transfer Hijack",
    category: "Sports",
    postCount: 137000,
  },
  {
    id: "2",
    title: "Stray Kids' 'KARMA' Hits Hard with Faker's Epic Cameo",
    category: "Entertainment",
    postCount: 33400,
  },
  {
    id: "3",
    title: "Isak Sidelined as Newcastle Faces Liverpool Transfer Storm",
    category: "Sports",
    postCount: 21000,
  },
];
