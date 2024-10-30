"use server";

interface CreatePostBody {
  user_id: string;
  text: string;
}

interface CreatePostResponse {
  id: string;
  user_id: string;
  text: string;
  created_at: string;
}

export async function createPost(
  body: CreatePostBody
): Promise<CreatePostResponse> {
  try {
    const res = await fetch(`${process.env.API_BASE_URL}/api/posts`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body),
    });

    if (res.ok) {
      const responseData: CreatePostResponse = await res.json();
      return responseData;
    } else {
      throw new Error(
        `Failed to create post: ${res.status} ${res.statusText}`
      );
    }
  } catch (error) {
    throw new Error("Unable to create post. Please try again later.");
  }
}
