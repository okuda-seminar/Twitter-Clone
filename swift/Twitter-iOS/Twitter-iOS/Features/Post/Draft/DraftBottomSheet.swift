import SwiftUI

struct DraftBottomSheetView: View {
  @Binding var isPresented: Bool
  @Binding var shouldDismissParentView: Bool

  public var draft: DraftModel

  private enum LocalizedString {
    static let deleteButtonText = "Delete"
    static let saveButtonText = "Save draft"
    static let dismissalButtonText = "Cancel"
  }

  var body: some View {
    VStack(spacing: 20) {
      Button(role: .destructive) {
        shouldDismissParentView = true
      } label: {
        HStack {
          Image(systemName: "trash.fill")
            .foregroundColor(.red)
          Text(LocalizedString.deleteButtonText)
            .foregroundColor(.red)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }

      Button {
        injectDraftService().save(draft: draft)
        shouldDismissParentView = true
      } label: {
        HStack {
          Image(systemName: "square.and.arrow.down")
            .foregroundColor(.secondary)
          Text(LocalizedString.saveButtonText)
            .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }

      Button(
        action: {
          isPresented = false
        },
        label: {
          HStack {
            Spacer()
            Text(LocalizedString.dismissalButtonText)
              .underline()
            Spacer()
          }
          .padding()
        }
      )
      .buttonStyle(.plain)
      .overlay(
        RoundedRectangle(cornerRadius: 24)
          .stroke(Color(uiColor: .brandedLightGrayBackground), lineWidth: 2)
      )
    }
    .padding()
    .frame(maxWidth: .infinity)
    .background(Color.white)
    .cornerRadius(15)
  }
}
