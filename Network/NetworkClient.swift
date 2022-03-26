//
//  NetworkClient.swift
//  ytsInCode
//
//  Created by zyad galal on 9/19/19.
//  Copyright © 2019 zyad galal. All rights reserved.
//

import Foundation
import Alamofire
class NetworkClient{
    typealias onSuccess<T> = (T) -> ()
    typealias onFailure = (_ errorMessage : String)->()
 
    static func performRequest<T> (_type:T.Type ,router : APIRouter , completion : @escaping (Swift.Result<T,Error>) -> ()) where T : Decodable{
        let token = UserDefaults.standard.object(forKey: "token")
        var headers: [String: String] = ["Content-Type":"application/json", "lang": "2"]
        
        if let token = token as? String {
            headers["Authorization"] = "Bearer \(token)"
            
            print("token: \(token)")
        }
        Alamofire.request(URL(string: router.path)!, method: router.method, parameters: router.parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            //print(response.data!)
            print("response: \(response)")
            print("statuscode:\(response.response?.statusCode)")
            switch response.result{
            case .success(_) :
                do{
                    let response = try JSONDecoder().decode(T.self, from: response.data!)
                    completion(.success(response))
                }
                catch let error{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
