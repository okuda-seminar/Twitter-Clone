"use client";

import { Messages } from "@/app/(protected)/message/_components/messages";
import { NewMessageModal } from "@/app/(protected)/message/_components/new-message-modal";
import { useRouter } from "next/navigation";

export default function Page() {
  const router = useRouter();
  return (
    <>
      <Messages />
      <NewMessageModal open={true} onClose={() => router.push("/message")} />
    </>
  );
}
