//
//  AFWrapper.swift
//  StudioApp
//
//  Created by user on 2018/12/21.
//  Copyright © 2018 ifundit. All rights reserved.
//

//
//  RequestManager.swift
//  QBadge
//
//  Created by Vincent Zhou on 2018/7/25.
//  Copyright © 2018 GBS CIC iX. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PKHUD

class AFWrapper:NSObject{
    /*
     let strURL = "YOUR_URL"
     
     AFWrapper.requestGETURL(strURL, success: {
     (JSONResponse) -> Void in
     print(JSONResponse)
     }) {
     (error) -> Void in
     print(error)
     }
     */
    class func requestGETURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        DispatchQueue.main.async(execute: {
            loadingNotice(title:"",msg:"loading",status:.Progress)
        })
        Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
            print(responseObject)
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
                DispatchQueue.main.async(execute: {
                    loadingHUD.hide()
                })
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
                DispatchQueue.main.async(execute: {
                    loadingHUD.hide()
                    loadingNotice(title:"error",msg:error.localizedDescription,status:.Error)
                })
            }
        }
    }
    class func requestGETEmailURL(_ strURL: String, success:@escaping (String) -> Void, failure:@escaping (Error) -> Void) {
        
        Alamofire.request(strURL).response { response in // method defaults to `.get`
            debugPrint(response)
            if response.error == nil{
                success("success")
            }else{
                let error :Error = response.error!
                failure(error)
            }
        }
    }
    class func requestGETSignInURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        
        Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
            print(responseObject)
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
                
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
                
            }
        }
    }
    //POST
    class func requestPOSTURL(_ strURL:String,paramters:[String:String],success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        loadingHUD.hide()
        loadingNotice(title:"",msg:"loading",status:.Success)
        
        Alamofire.request(strURL, method:.post, parameters: paramters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            print(response)
            switch response.result {
            case .success:
                let resJson = JSON(response.result.value!)
                success(resJson)
                loadingHUD.hide()
                break
            case .failure(let error):
                failure(error)
                loadingHUD.hide()
                let title = AFWrapper.commonEroor(response: response.response).0
                let msg = AFWrapper.commonEroor(response: response.response).1
                loadingNotice(title:title,msg:msg,status:.Error)
                loadingHUD.hide()
            }
        }
    }
    
    class func requestDELETEURL(_ strURL:String,paramters:[String:String],success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        loadingNotice(title:"",msg:"loading",status:.Success)
        Alamofire.request(strURL, method:.delete, parameters: paramters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            print(response.error ?? "Delete Error")
            switch response.result {
            case .success:
                let resJson = JSON(response.result.value!)
                success(resJson)
                loadingHUD.hide()
                break
            case .failure(let error):
                failure(error)
                loadingHUD.hide()
                let title = AFWrapper.commonEroor(response: response.response).0
                let msg = AFWrapper.commonEroor(response: response.response).1
                loadingNotice(title:title,msg:msg,status:.Error)
                loadingHUD.hide()
            }
        }
        
    }
    class func commonEroor(response:HTTPURLResponse?)->(String,String){
        var title = "WTF"
        var msg  = ",=msg"
        if let r = response{
            let code = r.statusCode
            switch code{
            case 403:
                title="403"
                msg="Forbidden"
                break;
            case 404:
                title="404"
                msg="serve not found"
                break;
            case 407:
                title="404"
                msg="Proxy Authentication Required"
                break;
            case 408:
                title="408"
                msg="Request Time-out"
                break;
            case 500:
                title="500"
                msg="Internal Server Error"
                break;
            case 503:
                title="503"
                msg="Service Unavailable"
                break;
            case 504:
                title="504"
                msg="Gateway Timeout"
                break;
            case 505:
                title="505"
                msg="HTTP Version Not Supported"
                break;
            default:
                title="idk"
                msg="idk"
            }
        }
        return (title,msg)
    }
    public static var loadingHUD = PKHUD.sharedHUD
    enum loadingType {
        case Progress;
        case Error;
        case Success;
        case notype;
    }
    class func loadingNotice(title:String?,msg:String,status:loadingType)->Void{
        DispatchQueue.main.async {
            switch status {
            case .Progress:
                let content = PKHUDProgressView(title: title , subtitle: msg)
                loadingHUD.contentView = content
                loadingHUD.show()
                break
            case .Error:
                let content = PKHUDErrorView(title: title , subtitle: msg)
                loadingHUD.contentView = content
                loadingHUD.show()
                loadingHUD.hide(afterDelay: 1.0)
                break
            case .Success:
                let content = PKHUDSuccessView()
                loadingHUD.contentView = content
                loadingHUD.show()
                loadingHUD.hide(afterDelay: 1.0)
                break
            case .notype:
                break;
            }
        }
        
    }
    
}
