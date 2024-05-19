//
//  NewMessageButton.swift
//  Twitter-iOS
//

import SwiftUI

struct CapsuleNewMessageEntrypointButton: View {
  @State var showSheet: Bool = false

  private enum LayoutConstant {
    static let buttonWidth = 160.0
    static let buttonHeight = 44.0
  }

  var body: some View {
    Button(
      action: {
        showSheet.toggle()
      },
      label: {
        Text(String(localized: "Write a message"))
          .underline()
          .frame(width: LayoutConstant.buttonWidth, height: LayoutConstant.buttonHeight)
      }
    )
    .clipShape(Capsule())
    .buttonStyle(RoundedButtonStyle())
    .sheet(isPresented: $showSheet) {
      NewMessageEditView()
    }
  }
}

struct CircleNewMessageEntrypointButton: View {
  @State var showSheet: Bool = false

  private enum LayoutConstant {
    static let buttonSize = 44.0
  }

  var body: some View {
    Button(
      action: {
        showSheet.toggle()
      },
      label: {
        Image(systemName: "plus")
          .frame(width: LayoutConstant.buttonSize, height: LayoutConstant.buttonSize)
      }
    )
    .clipShape(Circle())
    .buttonStyle(RoundedButtonStyle())
    .sheet(isPresented: $showSheet) {
      NewMessageEditView()
    }
  }
}

#Preview {
  VStack {
    CapsuleNewMessageEntrypointButton()
    CircleNewMessageEntrypointButton()
  }
}
