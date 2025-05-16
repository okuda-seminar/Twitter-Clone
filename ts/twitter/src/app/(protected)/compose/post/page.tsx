import { Home } from "@/app/(protected)/home/_components/home";
import { PostModal } from "@/app/@modal/(.)compose/post/_components/post-modal/post-modal";

export default function Page() {
  return (
    <>
      <Home />
      <PostModal isIntercepted={false} />
    </>
  );
}
