import SwiftUI

struct CheckboxStyle: ToggleStyle {
  public enum Style: String {
    case circleCheckboxStyle
    case squareCheckboxStyle
  }

  public let style: Style

  func makeBody(configuration: Configuration) -> some View {
    let (checkboxFillType, checkboxEmptyType): (String, String) = {
      switch style {
      case .circleCheckboxStyle:
        return ("checkmark.circle.fill", "circle")
      case .squareCheckboxStyle:
        return ("checkmark.square.fill", "square")
      }
    }()

    return HStack {
      configuration.label
      Image(systemName: configuration.isOn ? checkboxFillType : checkboxEmptyType)
        .foregroundColor(
          configuration.isOn ? Color(uiColor: .brandedBlue) : Color(uiColor: .lightGray)
        )
        .font(.system(size: 28.0, weight: .medium, design: .rounded))
    }
    .onTapGesture {
      configuration.isOn.toggle()
    }
  }
}

struct CheckboxStyleCatalog: View {
  @State private var isBoxOneChecked: Bool = false
  @State private var isBoxTwoChecked: Bool = false

  var body: some View {
    VStack {
      Toggle(isOn: $isBoxOneChecked) {
        Text("Checkbox1")
          .font(.system(.title2, design: .rounded))
        Spacer()
      }
      .toggleStyle(CheckboxStyle(style: .circleCheckboxStyle))
      .padding()

      Toggle(isOn: $isBoxTwoChecked) {
        Text("Checkbox2")
          .font(.system(.title2, design: .rounded))
        Spacer()
      }
      .toggleStyle(CheckboxStyle(style: .squareCheckboxStyle))
      .padding()
    }
  }
}

#Preview {
  CheckboxStyleCatalog()
}
