# How to Rotate ViewController/NavigationController in iOS Swift4

It might be tricky to create a whole iOS Swift project using portrait only and suddenly when your app is far down the road you need to give landscape orientation support for only one View Controller.

## Deployment Info – Device Orientation

If your project is already in portrait you won’t need to change anything. If not, make sure that only portrait is selected.
![Device Orientation](http://www.jairobjunior.com/images/labs/2016-03-06/device-orientation.png "Device Orientation")
## AppDelegate.swift
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            if let rootVC = self.topViewControllerWithRootViewController(rootViewController: window?.rootViewController){
                if rootVC.responds(to:Selector("canRotate")){
                    if rootVC.canRotate() == true {
                        return .allButUpsideDown
                    }else{
                        return .portrait
                    }
                } else{
                    return .portrait
                }
            }
            return UIInterfaceOrientationMask.allButUpsideDown
        }
```swift
    private func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController? {
        if (rootViewController == nil) { return nil }
        if (rootViewController.isKind(of: UITabBarController.self)) {
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UITabBarController).selectedViewController)
        } else if (rootViewController.isKind(of:UINavigationController.self)) {
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UINavigationController).visibleViewController)
        } else if (rootViewController.presentedViewController != nil) {
            return topViewControllerWithRootViewController(rootViewController: rootViewController.presentedViewController)
        }
        return rootViewController
    }
```

*The method **topViewControllerWithRootViewController** gets the top View Controller from the window and checks if it has the method/selector **canRotate** implemented, if so .allButUpsideDown is returned from supportedInterfaceOrientationsForWindow.
*## View Controller Extension

## ViewController Extension
    extension UIViewController{
    @objc func canRotate()->Bool{
        return false
    }
}
Now all you need to do is to override the canRotate method on the ViewController that need to be rotated.
    class ViewController: UIViewController {
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        }
        override func canRotate()->Bool{
		//return true means thata this page can be rotated.
            return false
        }
        
    }

And if you want to control the view controller's Rotation from Landscape to portrait inside of the UINavigation Controller,you need do one more step

//Set the pushed page as Portrait Only.

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
        }



### End