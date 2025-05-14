import { PostModal } from "@/app/(protected)/@modal/(.)compose/post/_components/post-modal/post-modal";
import { Home } from "@/app/(protected)/home/_components/home";

export default function Page() {
  return (
    <>
      <Home />
      <PostModal isIntercepted={false} />
    </>
  );
}
