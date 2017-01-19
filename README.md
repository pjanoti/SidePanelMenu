# SidePanelMenu
It gives an Android style side panel menu.

#####Install Cocoa Pods

If you have already installed Cocoa Pods then you can skip this step.

```
$ [sudo] gem install cocoapods
$ pod setup
```

#####Install `SideMenuView ` pod
Once Cocoa Pods has been installed, you can add `SideMenuView ` iOS Component to your project by adding a dependency entry to the Podfile in your project root directory.

```
$ edit Podfile
platform :ios, '9.0'
pod 'SideMenuView'
```

This sample shows a minimal Podfile that you can use to add `SideMenuView ` iOS Component dependency to your project. 
You can include any other dependency as required by your project.

Now you can install the dependencies in your project:

```
$ pod install
```

Once you install a pod dependency in your project, make sure to always open the Xcode workspace instead of the project file when building your project:

```
$ open App.xcworkspace
```

Now you can import `SideMenuView ` in your source files:

Swift

```swift
import SideMenuView
```

At this point `SideMenuView ` iOS Component is ready for use in your project.


### SideMenuView Component Usage Guideline

##### How to import?

***Step 1.*** Go to your `ViewController.swift` & `import SideMenuView`

***Step 2.*** Go to your `ViewController.swift` & add `SideMenuViewDelegate`

***Step 3.*** Create a variable of type `SideMenuView`

```swift
 var slideView: SideMenuView?

```

##### How to use?

```swift
 override func viewDidLoad() {
        super.viewDidLoad()
        self.addSidePanel()
        self.leftBarButton()
    }
```

```swift
func leftBarButton() {
        var leftBarButtons = [UIBarButtonItem]()
            let barButtonItem = UIBarButtonItem.init(image: UIImage(named: "menu_normal"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.menuButtonTapped))
            leftBarButtons.append(barButtonItem)
        if leftBarButtons.count > 0 {
            self.navigationItem.leftBarButtonItems = leftBarButtons
        }
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }
```
```swift
func menuButtonTapped() {
        self.showSidePanel()
    }
```

#### you can set the different properties of SideMenuView like `backGroundColor`, `separatorColor `, `separatorType `, `transparentViewMargin ` etc if you need to customize it otherwise it will take default values.
 
```swift
 func addSidePanel() {
        if self.slideView != nil {
            self.slideView?.removeFromSuperview()
            self.slideView = nil
        }
        
        let contents = self.sidePanelContents()
        self.slideView = SideMenuView.initMenuView(contents, slideDirection: .left, delegate: self)
        self.slideView?.isHidden = true
        self.slideView?.backGroundColor = UIColor.white
        self.slideView?.separatorColor = UIColor.init(colorLiteralRed: 86.0/255.0, green: 119.0/255.0, blue: 133.0/255.0, alpha: 1.0)
        self.slideView?.separatorType = UITableViewCellSeparatorStyle.singleLine
        self.slideView?.transparentViewMargin = 120
        self.view.addSubview(self.slideView!)
        self.slideView?.setupInitialConstraintWRTView(self.view, containerView: nil)
    }
    
    func sidePanelContents() -> [Item] {
        var sideContents = [Item]()
        let item1 = Item.init(title: "Feedback", iconName: "feedback", isSelected: false)
        sideContents.append(item1)
        let item2 = Item.init(title: "My Job", iconName: "myjobs", isSelected: false)
        sideContents.append(item2)
        
        return sideContents
    }

```

```swift
 func showSidePanel() {
        self.slideView?.lblUserName.text = "Prema Janoti"
        self.slideView?.userIView.image = UIImage(named: "placeholder")
        self.slideView?.menuTView.reloadData()
        self.slideView?.showSidePanelWithoutSlideEffectOnSuperView()
    }
    
    func removeSidePanel() {
        self.slideView?.removeSidePanelWithoutSlideEffectOnSuperView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeSidePanel()
    }
```

#### Use delegate method to perform actions on selected menu item -

```swift
 func didSelectItem(_ item: Item) {
      if item.title.caseInsensitiveCompare("Feedback") == ComparisonResult.orderedSame {
           // Do your stuf here 
        } else if item.title.caseInsensitiveCompare("My Jobs") == ComparisonResult.orderedSame {
           // Do your stuf here
        }
  
     self.removeSidePanel()
    }
```
