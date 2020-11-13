![CI](https://github.com/faberNovel/ADKeyboardManager/workflows/CI/badge.svg)
[![CocoaPods](https://img.shields.io/cocoapods/v/ADKeyboardManager.svg?style=flat)](https://github.com/faberNovel/ADKeyboardManager)
![Language](https://img.shields.io/badge/language-Swift%204-orange.svg)
[![Platform](https://img.shields.io/cocoapods/p/ADKeyboardManager.svg?style=flat)](https://github.com/faberNovel/ADKeyboardManager)
![License](https://img.shields.io/github/license/faberNovel/ADKeyboardManager.svg?style=flat)
[![Twitter](https://img.shields.io/badge/twitter-@FabernovelApp-blue.svg?style=flat)](https://twitter.com/FabernovelApp)

ADKeyboard manager is roughly one helper class to automatically handle the appearance and disappearance of the keyboard with a ScrollView.

## Usage

When the keyboard appears you almost always want the same behavior : that the selected UI element is kept visible in order for your user to see what he is typing.
That is exactly what ADKeyboardManager does, it automatically add insets to the containing scroll view and scrolls it in order to keep the view visible. On the keyboard disappearance your ScrollView returns to its previous inset values.

To initialize a KeyboardManager you just need to pass it the scrollView you want to adjust when the keyboard appears/disappears.

Since `KeyboardManager` relies on the notification center to know when the keyboard is showing or hiding you also need it to start observing these notifications, and at some point stop observing. In most case you want to do that during the appearance and disappearance of your viewController :
```swift
class MyViewController: UIViewController {
    private lazy var keyboardManager = KeyboardManager(scrollView: myScrollView)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardManager.startObservingKeyboard()
    }

    override func viewWillDisappear(_ animated: Bool) {
        keyboardManager.stopObservingKeyboard()
        super.viewWillDisappear(animated)
    }
}
```

If you need to perform additional changes when the scrolling animations are complete you can also conform to `KeyboardManagerDelegate` to be notified within the animation block execution.

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate ADKeyboardManager into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'ADKeyboardManager', '~> 6.0'
end
```

Then, run the following command:

```bash
$ pod install
```

## Credits

ADKeyboardManager is owned and maintained by [Fabernovel Technologies](https://technologies.fabernovel.com/). You can follow us on Twitter at [@FabernovelApp](https://twitter.com/FabernovelApp).


## License

ADKeyboardManager is released under the MIT license. [See LICENSE](LICENSE) for details.
