# AccordionHeaderView

A lightweight controller-based layout that embeds an accordion-style header into a `UIPageViewController`. Easily integrate dynamic, collapsible headers with swipeable page content.

![License](https://img.shields.io/github/license/codemostUK/AccordionHeaderView)


## 🚀 Features

- **Accordion Header View** 🏗️  
  Dynamically expands and collapses based on scroll interactions.

- **Embedded Page View Controller** 📖  
  Manages multiple pages within a single scrollable view.

- **Smooth Scrolling Experience** 🎯  
  Handles scroll direction and content offset calculations for seamless navigation.

![animation](Assets/animation.gif)


## 📦 Installation

### CocoaPods

```sh
pod 'AccordionHeaderView'
```

## 📁 Folder Structure

```
Sources/
 ├── AccordionHeaderView.swift
 ├── AccordionHeaderViewClient.swift
 └── AccordionHeaderViewClientVC.swift
Example/
 ├── AccordionHeaderViewExample/
 │   ├── ViewController.swift
 │   ├── PageViewController.swift
 │   ├── PageContentViewController.swift
 │   └── ...
 ├── AccordionHeaderViewExample.xcodeproj
 └── Podfile
```

## 📌 Usage

### 1️⃣ Accordion Header Behavior

The `AcordionHeaderViewDelegate` handles dynamic height adjustments as the user scrolls.  
Implemented in `ViewController.swift`.

### 2️⃣ Page Navigation

`PageViewController.swift` manages multiple pages with embedded content.  
`PageContentViewController.swift` populates the scrollable content.

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "embedPageViewController",
       let pageViewController = segue.destination as? PageViewController {
        pageViewController.acordionHeaderViewDelegate = self
    }
}
```

## 📄 License

MIT License. See [LICENSE](LICENSE) for details.
