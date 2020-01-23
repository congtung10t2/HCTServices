# HCTServices
Load image and json from webservice
```swift
    let option = UrlOptions(url: your_url)
    FileLoader.shared.downloadJson(ofType: [Post].self, with: option) { (value, error) in
    //do with your value
    }

    FileLoader.shared.downloadImage(with: option) { (value, error) in
    //do with your value
    }
  
```
  
  The rest of types will be added in the future.
