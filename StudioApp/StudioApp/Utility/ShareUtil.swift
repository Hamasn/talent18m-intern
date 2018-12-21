import Foundation
import UIKit
import SVProgressHUD

extension ShareUtil: UIDocumentInteractionControllerDelegate {
    
}

class ShareUtil: NSObject {
    static let shared = ShareUtil()
    
    private var document = UIDocumentInteractionController()
    
    func shareRoute(shareItem:UIBarButtonItem, name: String) {
        if let file = FileUtil.path(name: "/com.mmoaay.findme.routes".appending("/").appending(name.appending(".dae"))) {
            document = UIDocumentInteractionController(url: URL(fileURLWithPath: file))
            print(URL(fileURLWithPath: file))
            document.uti = "com.ibm.cio.be.ARiX.fmr"
            document.delegate = self
            document.presentOpenInMenu(from: shareItem, animated: true)
        }
    }
    
    func openRoute(file: URL) {
        let identity = FileUtil.identityForFile(file: file.lastPathComponent)
        
        if let route = RouteCacheService.shared.routes[identity] {
            SVProgressHUD.showInfo(withStatus: "Already got the route with name: ".appending(route.name))
            return
        }
        
        if let path = FileUtil.copyFile(at: file), let route = RouteCacheService.shared.getRoute(filePath: path) {
            SVProgressHUD.showInfo(withStatus: "Route with name: ".appending(route.name).appending(" added."))
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ReloadRoutes"), object: nil)
        } else {
            SVProgressHUD.showError(withStatus: "Open shared route failed!")
        }
    }
}
