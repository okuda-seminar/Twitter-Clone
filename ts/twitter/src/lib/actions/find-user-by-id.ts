"use server";

interface FindUserByIdBody {
  user_id: string;
}

export interface FindUserByIdResponse {
  id: string;
  username: string;
  display_name: string;
  bio: string;
  is_private: boolean;
  created_at: string;
  updated_at: string;
}

export async function findUserById({
  user_id,
}: FindUserByIdBody): Promise<FindUserByIdResponse> {
  try {
    const res = await fetch(
      `${process.env.API_BASE_URL}/api/users/${user_id}`,
      {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        },
      }
    );

    if (res.ok) {
      const responseData: FindUserByIdResponse = await res.json();
      return responseData;
    } else {
      throw new Error(`Failed to find user: ${res.status} ${res.statusText}`);
    }
  } catch (error) {
    console.error("Error find user:", error);
    throw new Error("Unable to find user. Please try again later.");
  }
}
