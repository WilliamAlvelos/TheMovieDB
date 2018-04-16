//
//  APIManager.swift
//  themoviedb
//
//  Created by William Alvelos on 21/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import Foundation
import Alamofire

class APIManager: NSObject {

    
    //MARK:- Vars and Lets
    static let themoviedb = "https://api.themoviedb.org/3/"

    static private var parameters : [String: Any] = ["api_key" : "9a2b7a2ab5dd6cde771641c09832a2f4"]

    static var imageCache = NSCache<NSString, UIImage>()

    
    //MARK:- Methods
    static func getFrom(_ url: String, params: [String: Any]? = nil,  completion: @escaping(Any?) -> Void) {
        
        Alamofire.request(url, method: .get, parameters: parameters)
            .validate()
            .responseJSON { (response) in
                print("GET: \(response.request?.url?.absoluteString ?? "")")
                
                switch response.result
                {
                case .success:
                    completion(response.data)
                    break
                    
                case .failure(let error):
                    completion(error)
                    break
                }
        }
    }
    

    
    static func downloadImage(url: String, completion: @escaping(Any?) -> Void) {
        print("IMAGE: \(url)")
        
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            completion(cachedImage)
        } else{
            Alamofire.request(url).response { (response) in
                if let data = response.data {
                    if let image = UIImage(data: data){
                        imageCache.setObject(image, forKey: url as NSString)
                        completion(image)
                    }else{
                        completion(NSError(domain: "", code: Errors.JSONNil.rawValue, userInfo: nil))
                    }
                }
                if let error = response.error {
                    completion(error)
                }
            }
        }
    }
}
