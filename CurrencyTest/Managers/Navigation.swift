
import Foundation
import UIKit

class Navigation : NSObject {
    
    static func showAlert(title: String, message: String, viewController: UIViewController?=nil) {
        
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            
            if let viewController = viewController {
                viewController.present(alertController, animated: true, completion: nil)
            } else {
                getCurrentViewController()?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    static func getCurrentViewController() -> UIViewController? {
        
        if let navigationController = getNavigationController() {
            
            return navigationController.visibleViewController
        }
        
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
    }
    
    static func getNavigationController() -> UINavigationController? {
        
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController {
            return navigationController as? UINavigationController
        }
        return nil
    }
}
