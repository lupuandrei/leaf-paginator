import Async
import Leaf

typealias HTML = String

public final class GFPaginator: TagRenderer {
  public init() {}
  
  public static let name = "paginator"
  
  public func render(tag: TagContext) throws -> Future<TemplateData> {
    try tag.requireParameterCount(1)
    let argumentBox = try GFPaginator.ArgumentBox(tag.parameters.first!)
    
    // without paging if there is only one page
    guard argumentBox.numberOfPages > 1 else {
      return Future.map(on: tag, { TemplateData.null })
    }
    
    return Future.map(on: tag, {
      TemplateData.string(argumentBox.styleType.generateHTML(argumentBox))
    })
  }
}
