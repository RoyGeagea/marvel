//
//  AppDelegate.swift
//  Marvel
//
//  Created by Roy Geagea on 1/31/19.
//  Copyright © 2019 RoyG. All rights reserved.
//

import UIKit
import Foundation
import CommonCrypto

let apiKey = "149efec8c928623a5d50a756243a8bd1"
let privateKey = "e19240eb681034680fc632f11f2f1986802b5669"

let baseURL = "https://gateway.marvel.com:443/v1/public/"

class DataManager: NSObject {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    class var sharedInstance: DataManager {
        struct Singleton {
            static let instance = DataManager()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
    }
    
    func getUserData(viewController: UIViewController, firstTime: Bool, completionHandler:@escaping (_ success: Bool, _ mainAppData: [CharacterViewModel]?, _ error: String?) -> Void) {
        Networking.GET(requestUrl: "characters", parameters: self.queryParameters(), success: { (data) in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(MainResponse.self, from: data as! Data)
                var charactersViewModel = [CharacterViewModel]()
                if let charactersArray = responseModel.data?.results {
                    for character in charactersArray {
                        let characterViewModel = CharacterViewModel(character: character)
                        charactersViewModel.append(characterViewModel)
                    }
                }
                completionHandler(true, charactersViewModel, nil)
            }
            catch {
                completionHandler(false, nil, NSLocalizedString("An error occurred, please try again later.", comment: ""))
            }
        }) { (errorMessage) in
            completionHandler(false, nil, errorMessage)
        }
    }
    
    func queryParameters() -> [String: Any] {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(ts + privateKey + apiKey)
        
        return ["apikey": "149efec8c928623a5d50a756243a8bd1", "hash": "744f26d534ba2ee85129e3078515a1cc", "ts": "1548965420", "orderBy": "name", "limit": "15", "offset": "0"]
    }
    
    func MD5(_ string: String) -> String? {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        
        if let d = string.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }
        
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
    
}
