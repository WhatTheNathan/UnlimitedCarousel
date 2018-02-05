# InfiniteCarousel
Highly customized Carousel Figure for iOS developed in Swift4

## Overview

![overview_1](Resources/overview_1.gif)

![overview_2](Resources/overview_2.gif)

![overview_3](Resources/overview_3.gif)

## Requirements

* iOS 9.0+
* Xcode 9
* Swift 4.0
* SnapKit && SDWebImage

## Installation

### CocoaPods

`InfiniteCarousel` is avaliable through CocoaPods. 

Add a pod entry for `InfiniteCarousel` to your Podfile:

```
pod 'InfiniteCarousel'
```

Install InfiniteCarousel into your project:

```
pod install
```

## Usage

The only thing you need to do is import `InfiniteCarousel`, create an instance and add it to your `View` via code or StoryBoard, and conform to it's datasource and delegate.

```swift
import InfiniteCarousel
```

```swift
let carousel = InfiniteCarousel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160))
carousel.delegate = self
carousel.dataSource = self
self.view.addSubview(carousel)
```

Just implement dataSource and delegate.

### dataSource

**Note: number of sections in infiniteCarousel is the key to create the infinite effect, 3 or 5 is recommended**.

```swift
extension ViewController: InfiniteCarouselDataSource {
    func numberOfSections(in carousel: InfiniteCarousel) -> Int {
        return 3
    }
    
    func numberOfFigures(for carousel: InfiniteCarousel) -> Int {
        return itemArray.count
    }
    
    func titleForFigure(at indexPath: ICIndexPath, in carousel: InfiniteCarousel) -> String {
        return itemArray[indexPath.row].title
    }
    
    func picLinkForFigure(at indexPath: ICIndexPath, in carousel: InfiniteCarousel) -> URL {
        return URL(string: itemArray[indexPath.row].picture_url)!
    }
}
```

### Delegate

```swift
extension ViewController: InfiniteCarouselDelegate {
    func infiniteCarousel(_ carousel: InfiniteCarousel, didSelectFigureAt indexPath: ICIndexPath) {
        let item = itemArray[indexPath.row]
        let url = item.link
        let webVC = WebViewController()
        webVC.webUrl = URL(string: url)
        webVC.navigationItem.title = item.title
        self.navigationController?.pushViewController(webVC, animated: true)
        }
    }
}
```

## Customization

```swift
let carousel = InfiniteCarousel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160))
carousel.pageControl.currentPageIndicatorTintColor = 
carousel.pageControl.tintColor = 
carousel.hidesForSinglePage = 
```

## Todo

- [ ] customized srcoll top-down or left-right
- [ ] customized enable PageControl
- [ ] Not longer dependent on `SapKit` and `SDWebImage`

## Change Log

* v1.1.0
* v1.0.1
* v1.0.0

## Contacts

via email: [@NathanLiu](http://nathanliuyolo@gmail.com)

## License

`InfiniteCarousel` is released under the [BSD 2-Clause "Simplified" License](LICENSE). See LICENSE for details.