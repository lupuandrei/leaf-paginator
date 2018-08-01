# GFPaginator

Vapor 3. Leaf Bootstrap paginator
This package comes as an extension of the [Pagination](https://github.com/vapor-community/pagination) package

## Requirements

1. Vapor 3. [Documentation](https://github.com/vapor/vapor)
2. Bootstrap 4. [Documentation](https://getbootstrap.com/docs/4.0/components/pagination/)
3. Pagination 1. [Documentation](https://github.com/vapor-community/pagination)


## Usage
Once set up, you can use it in your Leaf template files like any other tag:

```
#paginator(paginatorArgBox)
```

`#paginator` has one parameter, an object instantiate from struct `GFPaginator.ArgumentBox`.

You can configure the paging style by setting one of the two options (`GFPaginator.StyleType`):
1. disabled: buttons *(previous & next)* will be disabled if previous & next are `nil`
2. hidden: buttons *(previous & next)* will be hidden if previous & next are `nil`

### Example how to use

**controller.swift**:
```
import Pagination
import GFPaginator

class UserController: RouteCollection {
...
  func indexHandler(_ req: Request) throws -> Future<View> {
    return try User.query(on: req).paginate(for: req).flatMap({ (users) in
      let paginatorArgBox = GFPaginator.ArgumentBox(users.page)
      let context = IndexContext(users: users, paginatorArgBox: paginatorArgBox)
      return try req.view().render("User/index", context)      
    })
  }
}

extension UserController {
  struct IndexContext: Encodable {
    let users: Paginated<User>
    let paginatorArgBox: GFPaginator.ArgumentBox
  }
}

```

**index.leaf**:

```
#paginator(paginatorArgBox)
```

## Setup

### Add as dependency
Add Leaf Markdown as a dependency in your `Package.swift` file:

```
dependencies: [
    ...,
    .package(url: "https://github.com/lupuandrei/leaf-paginator", from: "0.0.6")
]
```

### Register with Leaf
To add the tag to Leaf, add it to your `LeafTagConfig`:
```
  var tags = LeafTagConfig.default()
  tags.use(GFPaginator(), as: GFPaginator.name)
  services.register(tags)
```

**Note**: it's important that you register the `LeafProvider` first otherwise this will override your `LeafTagConfig`.

Don't forget to import `GFPaginator` in the file you register the tag with `import GFPaginator`.
