import { useAuth } from "@/lib/components/auth-context";
import { ERROR_MESSAGES } from "@/lib/constants/error-messages";
import { VALIDATION_CONSTANTS } from "@/lib/constants/validation-constants";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { type SignupBody, signup } from "#src/lib/actions/signup";

interface UseSignupModalReturn {
  formValues: SignupBody;
  showPassword: boolean;
  handleInputChange: (field: keyof SignupBody, value: string) => void;
  togglePasswordVisibility: () => void;
  handleSignupAction: (
    prevState: string | undefined,
    formData: FormData,
  ) => Promise<string | undefined>;
  isSubmitDisabled: boolean;
  handleCloseButtonClick: () => void;
}

export const useSignupModal = (): UseSignupModalReturn => {
  const [formValues, setFormValues] = useState<SignupBody>({
    displayName: "",
    username: "",
    password: "",
  });
  const [showPassword, setShowPassword] = useState(false);
  const router = useRouter();
  const { setUser } = useAuth();

  const generateUsername = (displayName: string): string => {
    if (!displayName) return "";
    return displayName
      .toLowerCase()
      .replace(/[^\w]/gi, "")
      .substring(0, VALIDATION_CONSTANTS.USERNAME.MAX_LENGTH);
  };

  const handleInputChange = (field: keyof SignupBody, value: string) => {
    const updatedForm = {
      ...formValues,
      [field]: value,
    };

    if (field === "displayName") {
      updatedForm.username = generateUsername(value);
    }

    setFormValues(updatedForm);
  };

  const togglePasswordVisibility = () => {
    setShowPassword((prev) => !prev);
  };

  const handleSignupAction = async (
    prevState: string | undefined,
    formData: FormData,
  ) => {
    try {
      const displayName = formData.get("displayName") as string;
      const username = formData.get("username") as string;
      const password = formData.get("password") as string;

      const result = await signup({ displayName, username, password });

      if (!result.ok) {
        return `${ERROR_MESSAGES.SIGNUP_ERROR} (${result.error.statusText})`;
      }
      setUser(result.value.user);

      router.push("/home");
    } catch (error: unknown) {
      if (error instanceof Error) {
        return ERROR_MESSAGES.CONNECTION_ERROR;
      }
      return ERROR_MESSAGES.UNKNOWN_ERROR;
    }
  };

  const handleCloseButtonClick = () => {
    router.back();
  };

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/647
  // - Use a validation library to validate the form data.
  const isUsernameValid =
    formValues.username.length >= VALIDATION_CONSTANTS.USERNAME.MIN_LENGTH &&
    formValues.username.length <= VALIDATION_CONSTANTS.USERNAME.MAX_LENGTH;

  const isPasswordValid =
    formValues.password.length >= VALIDATION_CONSTANTS.PASSWORD.MIN_LENGTH &&
    formValues.password.length <= VALIDATION_CONSTANTS.PASSWORD.MAX_LENGTH;

  const isSubmitDisabled =
    !formValues.displayName || !isUsernameValid || !isPasswordValid;

  return {
    formValues,
    showPassword,
    handleInputChange,
    togglePasswordVisibility,
    handleSignupAction,
    isSubmitDisabled,
    handleCloseButtonClick,
  };
};
