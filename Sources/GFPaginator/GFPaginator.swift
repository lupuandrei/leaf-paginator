import Async
import Leaf

public final class GFPaginator: TagRenderer {
  public init() {}
  
  public static let name = "paginator"
  
  public func render(tag: TagContext) throws -> Future<TemplateData> {
    try tag.requireParameterCount(1)
    let _ = try GFPaginator.ArgumentBox(tag.parameters.first!)
    
//    debugPrint(pgtor, separator: " ")
    
//    try tag.requireParameterCount(5)
    
//    let current = tag.parameters[0].int!
//    let nextPage = tag.parameters[1].int
//    let previousPage = tag.parameters[2].int
//    let maxPage = tag.parameters[3].int!
//    let itemsPerPage = tag.parameters[4].int!
//
    // without paginator
//    guard maxPage > 1 else {
//      return Future.map(on: tag, {
//        TemplateData.null
//      })
//    }
//
//    let paginator = self.paginatorHTML2(previousPage, current, nextPage, itemsPerPage)
//
    return Future.map(on: tag, {
      TemplateData.string("paginator")
    })
  }
  
  /// Remove **Previous** and **Next** from paginator if **previousPage** and **nextPage** are nil
  private func paginatorHTML(_ previousPage: Int?, _ current: Int, _ nextPage: Int?, _ itemsPerPage: Int) -> String {
    var paginator = """
    <nav aria-label="Navigation">
    <ul class="pagination">
    """
    
    // previous page
    if let prev = previousPage {
      paginator += """
      <li class="page-item"><a class="page-link" href="?page=\(prev)&per=\(itemsPerPage)">Previous</a></li>
      """
    }
    
    // current page
    paginator += """
    <li class="page-item active"><a class="page-link" href="?page=\(current)&per=\(itemsPerPage)">\(current)</a></li>
    """
    
    // next page
    if let next = nextPage {
      paginator += """
      <li class="page-item"><a class="page-link" href="?page=\(next)&per=\(itemsPerPage)">Next</a></li>
      """
    }
    
    paginator += """
    </ul>
    </nav>
    """
    
    return paginator
  }
  
  /// Make **Previous** and **Next** disabled if **previousPage** and **nextPage** are nil
  private func paginatorHTML2(_ previousPage: Int?, _ current: Int, _ nextPage: Int?, _ itemsPerPage: Int) -> String {
    let paginator =  """
    <nav aria-label="Navigation">
    <ul class="pagination">
    <li class="page-item \(previousPage == nil ? "disabled" : "")"><a class="page-link" href="?page=\(previousPage ?? 0)&per=\(itemsPerPage)">Previous</a></li>
    <li class="page-item active"><a class="page-link" href="?page=\(current)&per=\(itemsPerPage)">\(current)</a></li>
    <li class="page-item \(nextPage == nil ? "disabled": "")"><a class="page-link" href="?page=\(nextPage ?? 0)&per=\(itemsPerPage)">Next</a></li>
    </ul>
    </nav>
    """
    return paginator
  }
}
