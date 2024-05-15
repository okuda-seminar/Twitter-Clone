import SwiftUI

struct CheckboxStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    return HStack {
      configuration.label
      Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
        .foregroundColor(
          configuration.isOn ? Color(uiColor: .brandedBlue) : Color(uiColor: .lightGray)
        )
        .font(.system(size: 28, weight: .medium, design: .rounded))
    }
    .onTapGesture {
      configuration.isOn.toggle()
    }
  }
}

struct CheckboxStyleCatalog: View {
  @State private var isChecked: Bool = false

  var body: some View {
    Toggle(isOn: $isChecked) {
      Text("Checkbox")
        .font(.system(.title2, design: .rounded))
      Spacer()
    }
    .toggleStyle(CheckboxStyle())
    .padding()
  }
}

#Preview{
  CheckboxStyleCatalog()
}
