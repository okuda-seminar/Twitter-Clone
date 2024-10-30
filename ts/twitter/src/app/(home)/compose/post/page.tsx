import PageLayout from "@/lib/compoenents/page-layout";
import { Home } from "../../_components/home";

export default function Page() {
  return (
    <PageLayout>
      {/*
        TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/485
        - Overlay the post modal on top of the current page.
      */}
      <Home isPostModalOpen={true} />
    </PageLayout>
  );
}
