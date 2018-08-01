import Async
import Leaf

typealias HTML = String

public final class GFPaginator: TagRenderer {
  public init() {}
  
  public static let name = "paginator"
  
  public func render(tag: TagContext) throws -> Future<TemplateData> {
    try tag.requireParameterCount(1)
    let argumentBox = try GFPaginator.ArgumentBox(tag.parameters.first!)
    
    
    return Future.map(on: tag, {
      TemplateData.string(argumentBox.styleType.generateHTML(argumentBox))
    })
  }
}


// MARK: - Generate HTML (Paginator)
extension GFPaginator.StyleType {
  func generateHTML(_ argumentBox: GFPaginator.ArgumentBox) -> HTML {
    switch self {
    case .disabled:
      return self.disableStyleHTML(argumentBox)
    case .hidden:
      return self.hiddenStyleHTML(argumentBox)
    }
  }
  
  /// Make **Previous** and **Next** disabled if **previousPage** and **nextPage** are nil
  private func disableStyleHTML(_ argumentBox: GFPaginator.ArgumentBox) -> HTML {
    var paginator = """
    <nav aria-label="Navigation">
    <ul class="pagination">
    """
    
    // previous page
    if let prev = argumentBox.previous {
      paginator += """
      <li class="page-item"><a class="page-link" href="?page=\(prev)&per=\(argumentBox.itemsPerPage)">Previous</a></li>
      """
    }
    
    // current page
    paginator += """
    <li class="page-item active"><a class="page-link" href="?page=\(argumentBox.current)&per=\(argumentBox.itemsPerPage)">\(argumentBox.current)</a></li>
    """
    
    // next page
    if let next = argumentBox.next {
      paginator += """
      <li class="page-item"><a class="page-link" href="?page=\(next)&per=\(argumentBox.itemsPerPage)">Next</a></li>
      """
    }
    
    paginator += """
    </ul>
    </nav>
    """
    
    return paginator
  }
  
  /// Remove **Previous** and **Next** from paginator if **previousPage** and **nextPage** are nil
  private func hiddenStyleHTML(_ argumentBox: GFPaginator.ArgumentBox) -> HTML {
    let paginator =  """
    <nav aria-label="Navigation">
    <ul class="pagination">
    <li class="page-item \(argumentBox.previous == nil ? "disabled" : "")"><a class="page-link" href="?page=\(argumentBox.previous ?? 0)&per=\(argumentBox.itemsPerPage)">Previous</a></li>
    <li class="page-item active"><a class="page-link" href="?page=\(argumentBox.current)&per=\(argumentBox.itemsPerPage)">\(argumentBox.current)</a></li>
    <li class="page-item \(argumentBox.next == nil ? "disabled": "")"><a class="page-link" href="?page=\(argumentBox.next ?? 0)&per=\(argumentBox.itemsPerPage)">Next</a></li>
    </ul>
    </nav>
    """
    return paginator
  }
}


