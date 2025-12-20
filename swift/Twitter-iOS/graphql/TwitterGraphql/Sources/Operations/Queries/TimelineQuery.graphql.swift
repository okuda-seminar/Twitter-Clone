// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class TimelineQuery: GraphQLQuery {
  public static let operationName: String = "TimelineQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query TimelineQuery($userId: ID!) { getReverseChronologicalHomeTimeline(userId: $userId) { __typename ... on Post { type id authorId text createdAt } } }"#
    ))

  public var userId: ID

  public init(userId: ID) {
    self.userId = userId
  }

  public var __variables: Variables? { ["userId": userId] }

  public struct Data: TwitterGraphql.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { TwitterGraphql.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getReverseChronologicalHomeTimeline", [GetReverseChronologicalHomeTimeline].self, arguments: ["userId": .variable("userId")]),
    ] }

    public var getReverseChronologicalHomeTimeline: [GetReverseChronologicalHomeTimeline] { __data["getReverseChronologicalHomeTimeline"] }

    /// GetReverseChronologicalHomeTimeline
    ///
    /// Parent Type: `TimelineItem`
    public struct GetReverseChronologicalHomeTimeline: TwitterGraphql.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { TwitterGraphql.Unions.TimelineItem }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .inlineFragment(AsPost.self),
      ] }

      public var asPost: AsPost? { _asInlineFragment() }

      /// GetReverseChronologicalHomeTimeline.AsPost
      ///
      /// Parent Type: `Post`
      public struct AsPost: TwitterGraphql.InlineFragment {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public typealias RootEntityType = TimelineQuery.Data.GetReverseChronologicalHomeTimeline
        public static var __parentType: any ApolloAPI.ParentType { TwitterGraphql.Objects.Post }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("type", String.self),
          .field("id", TwitterGraphql.ID.self),
          .field("authorId", TwitterGraphql.ID.self),
          .field("text", String.self),
          .field("createdAt", String.self),
        ] }

        public var type: String { __data["type"] }
        public var id: TwitterGraphql.ID { __data["id"] }
        public var authorId: TwitterGraphql.ID { __data["authorId"] }
        public var text: String { __data["text"] }
        public var createdAt: String { __data["createdAt"] }
      }
    }
  }
}
