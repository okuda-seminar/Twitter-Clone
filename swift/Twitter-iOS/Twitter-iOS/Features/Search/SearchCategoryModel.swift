import Foundation

enum SearchCategoryTabId: String {
  case forYou
  case trending
  case news
  case sports
  case entertainment
}

struct SearchCategoryModel {
  var title: String
  var tabId: SearchCategoryTabId
}
