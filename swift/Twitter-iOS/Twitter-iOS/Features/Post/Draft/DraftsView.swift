import SwiftUI

typealias didTapDraftsViewDismissalButtonCompletion = () -> Void

class DraftsViewObserver: ObservableObject {
  var didTapDismissalButton: didTapDraftsViewDismissalButtonCompletion?
}

public final class DraftsViewDataSource: ObservableObject {
  public var selectedDraft: DraftModel?
  public var savedDrafts: [DraftModel] = []
}

struct DraftsView: View {
  public var dataSource: DraftsViewDataSource
  public let viewObserver: DraftsViewObserver
  @State private var isEditing = false

  var body: some View {
    VStack {
      HStack {
        Button(action: {
          viewObserver.didTapDismissalButton?()
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
        ForEach(dataSource.savedDrafts.indices, id: \.self) { index in
          Text(dataSource.savedDrafts[index].text)
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
              Button(role: .destructive) {
                removeDraft(at: IndexSet([index]))
              } label: {
                Label("Delete", systemImage: "trash")
              }
            }
        }
        .onDelete(perform: removeDraft)
      }
      .listStyle(.plain)
      .frame(maxWidth: .infinity)
    }
  }

  func removeDraft(at offsets: IndexSet) {
    guard let index = offsets.first else { return }
    let draft = dataSource.savedDrafts[index]
    injectDraftService().remove(draft: draft)
    dataSource.savedDrafts.remove(atOffsets: offsets)
  }
}

#Preview {
  DraftsView(dataSource: DraftsViewDataSource(), viewObserver: DraftsViewObserver())
}
