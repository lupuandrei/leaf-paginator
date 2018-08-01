# GFPaginator

Vapor 3. Leaf Bootstrap paginator

# Usage
Once set up, you can use it in your Leaf template files like any other tag:

```
#paginator(paginatorArgBox)
```

# Requirements

1. Vapor 3. [Documentation](https://github.com/vapor/vapor)
2. Bootstrap 4. [Documentation](https://getbootstrap.com/docs/4.0/components/pagination/)
3. Pagination 1. [Documentation](https://github.com/vapor-community/pagination)

# Setup

## Add as dependency
Add Leaf Markdown as a dependency in your `Package.swift` file:

```
dependencies: [
    ...,
    .package(url: "https://github.com/lupuandrei/leaf-paginator", from: "0.0.6")
]
```

## Register with Leaf
To add the tag to Leaf, add it to your `LeafTagConfig`:
```
  var tags = LeafTagConfig.default()
  tags.use(GFPaginator(), as: GFPaginator.name)
  services.register(tags)
```

**Note**: it's important that you register the `LeafProvider` first otherwise this will override your `LeafTagConfig`.

Don't forget to import `GFPaginator` in the file you register the tag with `import GFPaginator`.
