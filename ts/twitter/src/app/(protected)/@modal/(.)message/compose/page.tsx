"use client";

import { NewMessageModal } from "@/app/(protected)/message/_components/new-message-modal";
import { useRouter } from "next/navigation";

export default function Page() {
  const router = useRouter();
  return <NewMessageModal open={true} onClose={() => router.back()} />;
}
