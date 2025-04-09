import SwiftUI

typealias didSelectDraftCompletion = (DraftModel) -> Void

class DraftsViewObserver: ObservableObject {
  var didSelectDraft: didSelectDraftCompletion?
}

public final class DraftsViewDataSource: ObservableObject {
  public var selectedDraft: DraftModel?
  public var savedDrafts: [DraftModel] = []
}

struct DraftsView: View {
  @Environment(\.dismiss) private var dismiss

  public var dataSource: DraftsViewDataSource
  public let viewObserver: DraftsViewObserver
  @State private var isEditing = false

  var body: some View {
    VStack {
      HStack {
        Button(action: {
          dismiss()
        }) {
          Text("Cancel")
            .underline()
        }
        .foregroundStyle(.primary)
        .frame(width: 64)
        .padding(.leading)

        Spacer()

        Text("Drafts")
          .font(.headline)

        Spacer()

        Button(action: {
          isEditing.toggle()
        }) {
          isEditing
            ? Text("Done")
              .underline()
            : Text("Edit")
              .underline()
        }
        .foregroundStyle(.primary)
        .frame(width: 48)
        .padding(.trailing)
      }
      .padding(.top)

      List {
        // Use ForEach directly with the identifiable data
        ForEach(dataSource.savedDrafts.indices, id: \.self) { index in
          let draft = dataSource.savedDrafts[index]
          Button {
            viewObserver.didSelectDraft?(draft)

          } label: {
            // Use an HStack within the label to control layout
            HStack {
              Text(draft.text)
                .lineLimit(1)  // Optional: prevent text wrapping
                .truncationMode(.tail)  // Optional: show ellipsis for long text
              Spacer()  // Pushes the Text to the left
            }
            .contentShape(Rectangle())
          }
          // Apply swipe actions directly to the Button or its label content
          .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button(role: .destructive) {
              removeDraft(at: [index])  // Pass the draft object
            } label: {
              Label("Delete", systemImage: "trash")
            }
          }
          // Use PlainButtonStyle to make it look like regular list content
          .buttonStyle(PlainButtonStyle())
          // Ensure text color is standard for the list context
          .foregroundStyle(.primary)
        }
        // Use the onDelete that works with ForEach(data)
        .onDelete(perform: removeDraft)
      }
      .listStyle(.plain)  // Keep plain style
      .environment(\.editMode, .constant(isEditing ? .active : .inactive))
    }
  }

  func removeDraft(at offsets: IndexSet) {
    guard let index = offsets.first else { return }
    let draft = dataSource.savedDrafts[index]
    injectDraftService().remove(draft: draft)
    dataSource.savedDrafts.remove(atOffsets: offsets)
  }
}

struct DraftsView_Previews: PreviewProvider {  // The PreviewProvider
  static var previews: some View {
    let dataSource = DraftsViewDataSource()
    dataSource.savedDrafts = [.init(text: "Hello")]
    let viewObserver = DraftsViewObserver()
    return DraftsView(dataSource: dataSource, viewObserver: viewObserver)
  }
}
