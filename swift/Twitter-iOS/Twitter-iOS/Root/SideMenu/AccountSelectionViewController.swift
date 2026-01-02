import UIKit

class AccountSelectionViewController: UIViewController {

  private enum LocalizedStrings {
    static let createAccountButtonTitle = "Create a new account"
    static let addExistingAccountButtonTitle = "Add an existing account"
  }

  private let editButton: UIButton = {
    let button = UIButton()
    button.setTitle("Edit", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitleColor(.black, for: .normal)
    return button
  }()

  private let headerLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.text = "Accounts"
    label.font = .preferredFont(forTextStyle: .headline)
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground

    // 2. Setup the Current Account Cell (simplified)
    let accountView = UIView()

    // 3. Setup Action Buttons
    let createAccountButton = UIButton(type: .system)
    createAccountButton.setTitle(LocalizedStrings.createAccountButtonTitle, for: .normal)
    createAccountButton.contentHorizontalAlignment = .leading

    let addExistingButton = UIButton(type: .system)
    addExistingButton.setTitle(LocalizedStrings.addExistingAccountButtonTitle, for: .normal)
    addExistingButton.contentHorizontalAlignment = .leading

    // Use a stack view to manage the layout
    let stackView = UIStackView(arrangedSubviews: [
      accountView,
      createAccountButton,
      addExistingButton,
    ])
    stackView.axis = .vertical
    stackView.spacing = 20
    stackView.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(editButton)
    view.addSubview(headerLabel)
    view.addSubview(stackView)

    let horizontalEdgePadding: CGFloat = 18
    let layoutGuide = view.safeAreaLayoutGuide

    // Constraints setup (Simplified)
    NSLayoutConstraint.activate([
      editButton.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor, constant: horizontalEdgePadding),
      editButton.widthAnchor.constraint(equalToConstant: 48),
      editButton.heightAnchor.constraint(equalToConstant: 44),
      editButton.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 18),
      headerLabel.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
      headerLabel.centerYAnchor.constraint(equalTo: editButton.centerYAnchor),
      stackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 18),
      stackView.leadingAnchor.constraint(equalTo: editButton.leadingAnchor),
      stackView.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -horizontalEdgePadding),
    ])
  }
}
