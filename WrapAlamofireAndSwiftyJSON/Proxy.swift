//
//  Proxy.swift
//
//
//  Created by roger on 2017/2/13.
//  Copyright © 2017年 roger. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class Proxy {
    
    let app = UIApplication.shared.delegate as! AppDelegate
    
    var valueHandle :((AnyObject) -> ())?
    var errorHandle :((NSError)->())?

    static let proxy = Proxy()
    
    /*
     success callback
     */
    func success(value:@escaping (AnyObject) -> ())->Self{
        //pass success handle
        self.valueHandle = value
        return self
    }
    
    /*
     error/failed callback
     */
    @discardableResult
    func error(error: @escaping (NSError)->())->Self{
        //pass error handle
        self.errorHandle = error
        return self
    }
    
    /*
     set default you need parameters:
     
     */
    func configureDefaultParams() -> [String:String]{
        
        var params = [String:String]()
        
        return params
    }
    
    /*
     universal request for custom API.
     Your custom API should use this method to send request.
     */
    static func request(functionName: String, method:HTTPMethod , urlString:String ,param:[String: AnyObject]?) -> Proxy {
        print("*****************************************")
        print("func = \(functionName)")
        print("urlString = \(urlString)")
        print("param = \(param)")
        print("*****************************************")
        
        Alamofire.request(URL(string: urlString)!,method: method,parameters: param)
            .validate()
            .responseJSON { response in
                print(response)
                let jsonVar = JSON(response.value ?? "")
                print(jsonVar)
                switch response.result{
                case .success:
                    proxy.valueHandle?(jsonVar as AnyObject)
                    break
                    
                case .failure(let error):
                    proxy.errorHandle?(error as NSError)
                    break
                    
                }
        }
        return proxy
    }

    static func fetchAPI() -> Proxy{

        let urlString : String = "https://jsonplaceholder.typicode.com/posts"

        return request(functionName: #function, method: .get, urlString: urlString, param: nil)
    }
    
}
