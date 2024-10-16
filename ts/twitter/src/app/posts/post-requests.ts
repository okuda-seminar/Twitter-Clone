"use server";

export async function PostRequests(data: { user_id: string; text: string }) {
  try {
    const res = await fetch(`http://x_app:80/api/posts`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data),
    });
    if (res.ok) {
      console.log(`status: ${res.status}`);
      return await res.json();
    } else {
      throw new Error(`HTTP error! status: ${res.status}`);
    }
  } catch (error) {
    console.error("Error creating post:", error);
    throw error;
  }
}
