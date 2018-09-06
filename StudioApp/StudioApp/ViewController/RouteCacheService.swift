//
//  RouteCacheService.swift
//  StudioApp
//
//  Created by user on 2018/8/30.
//  Copyright © 2018 ifundit. All rights reserved.
//

import Foundation
import SceneKit

class RouteCacheService {
    static let shared = RouteCacheService()
    
    init() {
        FileUtil.createFolder(name: "/com.mmoaay.findme.routes")
        getAllRoutes()
    }
    
    func getAllRoutes() {
        if let path = FileUtil.path(name: "/com.mmoaay.findme.routes") {
            let files = FileUtil.allFiles(path: path, filterTypes: ["scn"])
            for file in files {
                let filePath = path.appending("/").appending(file)
                getRouteDae(filePath: filePath)
            }
        }
    }
    @discardableResult
    func getRoute(filePath: String) -> Route? {
        if let route = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? Route {
            routes[String(route.identity)] = route
            return route
        } else {
            return nil
        }
    }
    @discardableResult
    func getRouteDae(filePath: String) -> RouteDae? {
        if let route = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? RouteDae {
            routesDae[String(route.name)] = route
            return route
        } else {
            return nil
        }
    }
    
    @discardableResult
    func getRoutex(filePath: URL) -> Route? {
        let optData = try? Data(contentsOf: filePath)
        guard let data = optData else {
            return nil
        }
        let unarchiver = NSKeyedUnarchiver(forReadingWith:data)

        do {
            let object = try unarchiver.decodeTopLevelObject()
            if let route = object as? Route{
                routes[String(route.identity)] = route
                return route
            }
            else{
                return nil
            }
        }
        catch {
            return nil
        }
        
    }
    func getRoute1(filePath: URL) -> Route? {
        Route.registerClassName()
        let optData = try? Data(contentsOf: filePath)
        guard let data = optData else {
            return nil
        }
        let unarchiver = NSKeyedUnarchiver(forReadingWith:data)
        do {
            let object = try unarchiver.decodeTopLevelObject()
            if let route = object as? Route{
                routes[String(route.identity)] = route
                return route
            }
            else{
                return nil
            }
        }
        catch {
            return nil
        }
        

    }
    @discardableResult
    func getRoutePC(filePath: String) -> Route? {
        if let route = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? Route {
            //  routes[String(route.identity)] = route
            return route
        } else {
            return nil
        }
    }
    var routes: [String : Route] = [ : ]
    var routesDae: [String : RouteDae] = [ : ]
    
    func route(identity: Int64) -> Route? {
        return routes[String(identity)];
    }
    
    func routes(prefix: String) -> [Route] {
        return Array(self.routes.values).filter { (route) -> Bool in
            return route.name.lowercased().contains(prefix.lowercased())
        }
    }
    
    func allRoutes() -> [Route] {
        return Array(self.routes.values)
    }
    func allRoutesDae() -> [RouteDae] {
        return Array(self.routesDae.values)
    }
    
    @discardableResult
    func addRoute(route: Route) -> Bool {
        routes[String(route.identity)] = route
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ReloadRoutes"), object: nil)
        
        if let file = FileUtil.path(name: "/com.mmoaay.findme.routes".appending("/").appending(String(route.identity).appending(".fmr"))) {
            return NSKeyedArchiver.archiveRootObject(route, toFile: file)
        } else {
            return false
        }
    }
    
    @discardableResult
    func addRouteDae2(route:RouteDae) ->Bool{
 //       routes[String(route.identity)] = route
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ReloadRoutes"), object: nil)
        
        if let file = FileUtil.path(name: "/com.mmoaay.findme.routes".appending("/").appending(String(route.name).appending(".dae"))) {
            return NSKeyedArchiver.archiveRootObject(route, toFile: file)
        } else {
            return false
        }
    }
    
    @discardableResult
    func addRouteDae(route:RouteDae) ->Bool{
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ReloadRoutes"), object: nil)
        if let fileUrl = URL(string: FileUtil.path(name: "/com.mmoaay.findme.routes".appending("/").appending(String(route.name)))!) {
            let test = URL(fileURLWithPath: FileUtil.path(name: "/com.mmoaay.findme.routes".appending("/").appending(String(route.name).appending(".scn")))!)
            print(test.absoluteString)
//            var arr = NSArray()
//            for child in route.scene.rootNode.childNodes{
//                let a = (child.position,child.transform,child.rotation)
//                arr.adding(a)
//            }
//            let filePath:String = NSHomeDirectory() + "/Documents/arr.plist"
//            arr.write(toFile: filePath, atomically: true)
            return route.scene.write(to: test , options: nil, delegate: nil, progressHandler: { (totalProgress, error, stop) in
                print("Progress \(totalProgress) Error: \(String(describing: error))")
            })
        } else {
            return false
        }
    }
    
    @discardableResult
    func delRoute(route: Route) -> Bool {
        routes.removeValue(forKey: String(route.identity))
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ReloadRoutes"), object: nil)
        
        if let file = FileUtil.path(name: "/com.mmoaay.findme.routes".appending("/").appending(String(route.identity).appending(".fmr"))) {
            return FileUtil.delFile(path: file)
        } else {
            return false
        }
    }
}
