import Pagination
import TemplateKit

extension GFPaginator {
  public class ArgumentBox: Encodable {
    let current: Int
    let next: Int?
    let previous: Int?
    let numberOfPages: Int
    let itemsPerPage: Int?
    let styleType: GFPaginator.StyleType
    
    public init(current: Int, next: Int? = nil, previous: Int? = nil, numberOfPages: Int, itemsPerPage: Int? = nil, styleType: GFPaginator.StyleType = .disabled) {
      self.current = current
      self.next = next
      self.previous = previous
      self.numberOfPages = numberOfPages
      self.itemsPerPage = itemsPerPage
      self.styleType = styleType
    }
    
    public init(_ pageInfo: PageInfo, styleType: GFPaginator.StyleType = .disabled) {
      self.current = pageInfo.position.current
      self.next = pageInfo.position.next
      self.previous = pageInfo.position.previous
      self.numberOfPages = pageInfo.data.total
      self.itemsPerPage = pageInfo.data.per
      
      self.styleType = styleType
    }
    
    internal init(_ templateData: TemplateData) throws {
      guard let dictionary = templateData.dictionary else { throw ErrorType.invalidArguments }
      guard let styleTypeCode = dictionary["styleType"]?.int, let styleType =  GFPaginator.StyleType(rawValue: styleTypeCode) else { throw ErrorType.invalidArguments }
      
      self.current = (dictionary["current"]?.int)!
      self.next = dictionary["next"]?.int
      self.previous = dictionary["previous"]?.int
      self.numberOfPages = (dictionary["numberOfPages"]?.int)!
      self.itemsPerPage = (dictionary["itemsPerPage"]?.int)!
      self.styleType = styleType
    }
    
  }
}


// MARK: - Error type
extension GFPaginator.ArgumentBox {
  public enum ErrorType: Error {
    case invalidArguments
  }
}



