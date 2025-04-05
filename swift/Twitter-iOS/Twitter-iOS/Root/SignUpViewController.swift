import SwiftUI
import UIKit

final class SignUpViewController: UIViewController {

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: SignUpView())
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    NotificationCenter.default.addObserver(
      self, selector: #selector(dismissWithAnimation),
      name: .authServiceDidChangeAuthenticationState, object: nil)

    guard let hostingView = hostingController.view else { return }
    view.backgroundColor = .systemBackground
    view.addSubview(hostingView)
    NSLayoutConstraint.activate([
      hostingView.topAnchor.constraint(equalTo: view.topAnchor),
      hostingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      hostingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hostingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }

  @objc func dismissWithAnimation() {
    DispatchQueue.main.async { [weak self] in
      self?.dismiss(animated: true)
    }
  }
}

struct SignUpView: View {
  @State private var email = ""
  @State private var userName = ""
  @State private var displayName = ""
  @State private var password = ""
  @State private var confirmPassword = ""
  @State private var isSecurePassword = true
  @State private var isSecureConfirmPassword = true

  var body: some View {
    VStack {
      Text("Sign Up")
        .font(.largeTitle)
        .fontWeight(.bold)
        .padding()

      // Email TextField
      TextField("Email", text: $email)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .keyboardType(.emailAddress)
        .autocapitalization(.none)
        .padding(.bottom, 16)

      // Username TextField
      TextField("User Name", text: $userName)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .autocapitalization(.none)
        .padding(.bottom, 16)

      // Username TextField
      TextField("Display Name", text: $displayName)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .autocapitalization(.none)
        .padding(.bottom, 16)

      // Password SecureField
      HStack {
        if isSecurePassword {
          SecureField("Password", text: $password)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        } else {
          TextField("Password", text: $password)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }

        Button(action: {
          isSecurePassword.toggle()
        }) {
          Image(systemName: isSecurePassword ? "eye.slash.fill" : "eye.fill")
            .foregroundColor(.gray)
        }
        .padding(.trailing, 8)
      }
      .padding(.bottom, 16)

      // Confirm Password SecureField
      HStack {
        if isSecureConfirmPassword {
          SecureField("Confirm Password", text: $confirmPassword)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        } else {
          TextField("Confirm Password", text: $confirmPassword)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }

        Button(action: {
          isSecureConfirmPassword.toggle()
        }) {
          Image(systemName: isSecureConfirmPassword ? "eye.slash.fill" : "eye.fill")
            .foregroundColor(.gray)
        }
        .padding(.trailing, 8)
      }
      .padding(.bottom, 24)

      // Sign Up Button
      Button(action: {
        // Handle sign-up action here
        Task {
          await injectAuthService().signUp(
            email: $email.wrappedValue,
            userName: $userName.wrappedValue,
            displayName: $displayName.wrappedValue,
            password: $password.wrappedValue)
        }
      }) {
        Text("Sign Up")
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(8)
      }
      .padding(.bottom, 16)

      // Already have an account link
      HStack {
        Text("Already have an account?")
        Button(action: {
          // Handle navigate to login
          print("Navigate to login")
        }) {
          Text("Log in")
            .fontWeight(.bold)
            .foregroundColor(.blue)
        }
      }
    }
    .padding()
  }
}

struct SignUpView_Previews: PreviewProvider {
  static var previews: some View {
    SignUpView()
  }
}
