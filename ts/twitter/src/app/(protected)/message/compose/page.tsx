"use client";

import { useRouter } from "next/navigation";
import { NewMessageModal } from "../../@modal/(.)message/compose/_components/new-message-modal/new-message-modal";

export default function Page() {
  const router = useRouter();
  return (
    <NewMessageModal open={true} onClose={() => router.push("/message")} />
  );
}
