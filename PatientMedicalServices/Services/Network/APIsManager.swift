////
////  APIsManager.swift
////  E4 Patient
////
////  Created by Mostafa Abd ElFatah on 5/24/22.
////
//
//import Alamofire
//import Foundation
//
//
//enum APIsManager {
//    
//    public static func fetch<Model>(
//        _ val: Model.Type, from url:URL,  method:HTTPMethod,
//        params:[String:Any]? = nil, header:HTTPHeaders? = nil ,
//        encoding:ParameterEncoding = JSONEncoding.default,
//        handler: @escaping ( (Swift.Result<Model, NetworkError>) -> Void )
//    ) where Model: Decodable, Model: Encodable {
//        
//        Alamofire.request( url, method: method, parameters: params, encoding: encoding, headers: header)
//            .responseJSON(completionHandler: { (response) in
//                switch response.result {
//                case .success(let value):
//                    print(value)
//                    guard let data = response.data else {
//                        handler(.failure(.invalidData))
//                        return
//                    }
//                    do {
//                        let decodedResponse = try JSONDecoder().decode(Model.self, from: data)
//                        handler(.success(decodedResponse))
//                    } catch {
//                        handler(.failure(.custom(error.localizedDescription)))
//                        print(error)
//                    }
//                    break
//                case .failure(let error):
//                    handler(.failure(.custom(error.localizedDescription)))
//                    break
//                    
//                }
//            })//end closure
//    }//end function
//}
