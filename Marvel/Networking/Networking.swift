//
//  AppDelegate.swift
//  Marvel
//
//  Created by Roy Geagea on 1/31/19.
//  Copyright © 2019 RoyG. All rights reserved.
//

import UIKit
import Alamofire

class Networking: NSObject {
    
    override init () {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
    }
    
    class func GET(requestUrl : String , parameters : Dictionary<String, Any>, success: @escaping (_ response:Any) -> Void, failure: @escaping (_ message: String) -> Void) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
            
            var urlComponents = URLComponents(string: baseURL + requestUrl)!
            var items = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: value as! String)
                items.append(queryItem)
            }
            urlComponents.queryItems = items
            
            
            var request = URLRequest(url: urlComponents.url!)
            request.httpMethod = HTTPMethod.get.rawValue
            
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            
            OperationQueue.main.addOperation {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
            let manager = Alamofire.SessionManager.default
            manager.request(request).responseJSON { response in
                OperationQueue.main.addOperation {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                switch response.result
                {
                case .success:
                    let resultString = String(data: response.data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
                    
                    if  let dictionary = self.convertToDictionary(text: resultString as String) {
                        if dictionary["code"] as! Int == 200 {
                            success(response.data!)
                        }
                        else {
                            failure(dictionary["status"] as! String)
                        }
                    }
                    else {
                        failure("Error parsing")
                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    failure(error.localizedDescription)
                    break
                }
            }
            
        } catch {
            print("JSON serialization failed:  \(error)")
            failure(error.localizedDescription)
        }
    }
    
    class func convertToDictionary(text: String) -> NSDictionary? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
            }
            catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}

