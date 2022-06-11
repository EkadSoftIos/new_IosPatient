//
//  AlamofireMultipart.swift
//  Roaya
//
//  Created by mohab on 3/3/20.
//  Copyright © 2020 panorama. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class AlamofireMultiPart{
    
    static func PostMultiWithModel<T: Codable>(model :T.Type , url: String, Images: [UploadDataa]?,header:[String:Any]?, parameters:[String: Any]?, completion: @escaping (ServerResponse<T>) -> Void) {
        let headers : HTTPHeaders = ["Content-Type": "multipart/form-data","lang": "2"]
        AF.upload(multipartFormData: { (multipartFormData) in

//      upload(multipartFormData: { (multipartFromData) in
        if parameters != nil{
          for (key, value) in parameters! {
              multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
          }
        }
        
        if let images = Images{
            for uploadData in images{
                print(uploadData.Key)
                multipartFormData.append(uploadData.data,
                                         withName: uploadData.Key,
                                         fileName: "\(Date().timeIntervalSince1970).jpg",
                                         mimeType: "image/jpeg")
            }
        }

      }, to: url, usingThreshold: UInt64.init(), method: .post,
                  headers: headers).responseJSON(completionHandler:{ result in
            if let error = result.error {
                print(error)
                completion(ServerResponse<T>.failure(error))
//                completionHandler(nil, false)
            }else if result.data != nil{
                do {
                    let decoder = JSONDecoder()
                    let modules = try decoder.decode(model, from: result.data!)
                    completion(ServerResponse<T>.success(modules))
                } catch {
                    completion(ServerResponse<T>.failure(error))
                }
            }
            
            
         /*
            
            {
                AF.upload.responseJSON(completionHandler: { (response) in
                    AF.req
                  switch response.result {
                  case .success(let value):
                    do {
                      let decoder = JSONDecoder()
                      let modules = try decoder.decode(model, from: response.data!)
                      completion(ServerResponse<T>.success(modules))
                    }catch {
                      print("catch >>>>", error.localizedDescription)
                      completion(ServerResponse<T>.failure(error))
                    }
                     
                  case .failure(let error):
                    print(error)
                    completion(ServerResponse<T>.failure(error))
                  }
                })
            }
*/
        
      })
    }
    
    
}
enum ServerResponse<T> {
    case success(T), failure(Error?)
}
struct UploadDataa {
    var data : Data
    var Key : String
}

struct UploadDataURL {
    var data: URL
    var name: String
}
