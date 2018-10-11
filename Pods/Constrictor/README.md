# Constrictor 🐍

[![Build Status](https://travis-ci.org/pedrommcarrasco/Constrictor.svg?branch=master)](https://travis-ci.org/pedrommcarrasco/Constrictor) 
[![codecov](https://codecov.io/gh/pedrommcarrasco/Constrictor/branch/master/graph/badge.svg)](https://codecov.io/gh/pedrommcarrasco/Constrictor)
[![CocoaPods](https://img.shields.io/cocoapods/v/Constrictor.svg)](https://cocoapods.org/pods/Constrictor)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![apm](https://img.shields.io/apm/l/vim-mode.svg)](https://github.com/pedrommcarrasco/Constrictor/blob/master/LICENSE)


***(Boe)*** Constrictor's AutoLayout µFramework with the goal of simplifying your constraints by reducing the amount of code you have to write.

## Installation 📦 
### CocoaPods
Constrictor's available through [CocoaPods](https://cocoapods.org/pods/Constrictor). To do so, add the following line to your PodFile:

```swift
pod 'Constrictor'
```
And then run the following command in terminal:

```swift
pod install
```

### Carthage
Add this to your Cartfile:

```swift
github "pedrommcarrasco/Constrictor"
```

And then run the following command in terminal:

```swift
carthage update
```

## Usage Example ⌨️ 
After installing Constrictor, you should import the framework:

```swift
import Constrictor
```

Once imported you can start using Constrictor to apply constraints to your views programmatically.

Bellow, you'll be able to see a working example. First, we start by configuring three simple UIViews (assuming we're in a UIViewController)

```swift
let redView = UIView()
redView.backgroundColor = .red
view.addSubview(redView)

let blueView = UIView()
blueView.backgroundColor = .blue    
view.addSubview(blueView)

let greenView = UIView()
greenView.backgroundColor = .green    
redView.addSubview(greenView)
```

Bellow, there's a comparison on how to apply constraints with and without Constrictor. There's also a documentation dedicated page available [here](https://github.com/pedrommcarrasco/Constrictor/blob/master/DOCUMENTATION.md).

### How you're *probably* doing it without Constrictor 😰

```swift
[redView, blueView, greenView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

if #available(iOS 11.0, *) {
    let safeArea = view.safeAreaLayoutGuide
    
    NSLayoutConstraint.activate([
        blueView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
	blueView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ]) 
} else {
    let safeLayoutGuide = UILayoutGuide()
    view.addLayoutGuide(safeLayoutGuide)
        
    NSLayoutConstraint.activate([
        safeLayoutGuide.topAnchor.constraint(equalTo: topLayoutGuide),
	safeLayoutGuide.bottomAnchor.constraint(equalTo: bottomLayoutGuide),
        safeLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        safeLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
 
        blueView.centerXAnchor.constraint(equalTo: safeLayoutGuide.centerXAnchor),
	blueView.centerYAnchor.constraint(equalTo: safeLayoutGuide.centerYAnchor)
    ]) 
}

NSLayoutConstraint.activate([
   redView.topAnchor.constraint(equalTo: view.topAnchor),
   redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
   redView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
   redView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
   
   blueView.widthAnchor.constraint(equalToConstant: 75.0),
   blueView.heightAnchor.constraint(equalToConstant: 75.0),
   
   greenView.widthAnchor.constraint(equalTo: blueView.widthAnchor),
   greenView.heightAnchor.constraint(equalTo: redView.heightAnchor),
   greenView.centerYAnchor.constraint(equalTo: blueView.centerYAnchor),
   greenView.trailingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: 50.0)
])
```

### How you can do it with Constrictor 😍
```swift
redView.constrictEdges(to: self, withinGuides: false)
        
blueView.constrictSize(to: 75.0)
     .constrictCenter(in: self)

greenView.constrict(to: blueView, attributes: .width, .centerYGuide)
     .constrictToParent(attributes: .height)
     .constrict(.trailing, to: blueView, attribute: .leading, with: 50.0)
```

##  Sample Project 📲
There's a sample project in this repository called [Example](https://github.com/pedrommcarrasco/Constrictor/tree/master/Example), if you want to take a look at Constrictor before using it in your projects, feel free to take a look at it and try to apply some constraints with it.

## To-Do ✅ 
- [x] Code Documentation
- [x] TravisCI integration
- [x] CodeCoverage.io integration
- [x] Unit Testing
- [x] SafeAreas & LayoutGuides
- [x] UILayoutPriority + and - operators
- [ ] Save/return constraints so it's easier to support animations

## Contributing 🙌 
Feel free to contribute to this project by [reporting bugs](https://github.com/pedrommcarrasco/Constrictor/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc) or open [pull requests](https://github.com/pedrommcarrasco/Constrictor/pulls?q=is%3Apr+is%3Aopen+sort%3Aupdated-desc).

## License ⛔
Constrictor's available under the MIT license. See the [LICENSE](https://github.com/pedrommcarrasco/Constrictor/blob/master/LICENSE) file for more information.
