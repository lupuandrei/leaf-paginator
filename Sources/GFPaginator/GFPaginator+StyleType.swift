import Vapor

extension GFPaginator {
  /// HTML Paginator. style type
  ///
  /// - disabled: buttons *(previous & next)* will be disabled if previous & next are nil
  /// - hidden: buttons *(previous & next)* will be hidden if previous & next are nil
 public enum StyleType: Int, Encodable {    
    case disabled
    case hidden
  }
}
