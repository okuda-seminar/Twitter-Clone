//
//  NewTweetSheet.swift
//  Twitter-iOS
//

import SwiftUI

struct NewTweetEditView: View {
  @Environment(\.dismiss) private var dismiss
  @State private var tweetText: String = ""
  @FocusState private var isFocused: Bool

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/42 - Polish NewTweetSheetView UI.
  var body: some View {
    VStack {
      HStack {
        Button(action: {
          dismiss()
        }, label: {
          Text("Cancel")
            .underline()
            .foregroundStyle(Color.primary)
        })
        Spacer()
        NewTweetButton()
      }
      ZStack(alignment: .topLeading) {
        // UITextView looks better here.
        TextEditor(text: $tweetText)
          .focused($isFocused)
          .onAppear {
            isFocused = true
          }
        if tweetText.isEmpty {
          Text("What's happening?")
            .foregroundStyle(Color(UIColor.placeholderText))
        }
      }
    }
    .padding()
    Spacer()
  }
}

#Preview {
  NewTweetEditView()
}
