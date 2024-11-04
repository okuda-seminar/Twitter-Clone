import { PostModal } from "@/app/@modal/(.)compose/post/_components/post-modal/post-modal";
import { Home } from "@/app/home/_components/home";

export default function Page() {
  return (
    <>
      <Home />
      <PostModal isIntercepted={false} />
    </>
  );
}
