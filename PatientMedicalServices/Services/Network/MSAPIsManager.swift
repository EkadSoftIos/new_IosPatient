//
//  MSAPIsManager.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/24/22.
//

import Alamofire
import Foundation
import Kingfisher


protocol MSAPIsManagerProtocol: AnyObject {
    func fetch<Model>(_ model:Model.Type , from networkURL:NetworkURL,
                      handler: @escaping ( (Swift.Result<Model, NetworkError>) -> Void )
    ) where Model: Decodable, Model: Encodable
}


class MSAPIsManager: MSAPIsManagerProtocol{
    
    func fetch<Model>(_ model:Model.Type , from networkURL:NetworkURL,
                      handler: @escaping ( (Swift.Result<Model, NetworkError>) -> Void )
    ) where Model: Decodable, Model: Encodable {
        
        guard let url = networkURL.url else {
            handler(.failure(.invalidURL))
            return
        }
        
        Alamofire.request( url, method: networkURL.method, parameters: networkURL.params, encoding: networkURL.encoding, headers: networkURL.header)
            .responseJSON { [weak self] (response) in
                guard self != nil else { return }
                switch response.result {
                case .success(_):
                    guard let data = response.data else {
                        handler(.failure(.invalidData))
                        return
                    }
                    do {
                        let decodedResponse = try JSONDecoder().decode(Model.self, from: data)
                        handler(.success(decodedResponse))
                    } catch {
                        handler(.failure(.custom(error.localizedDescription)))
                        print(error)
                    }
                    break
                case .failure(let error):
                    handler(.failure(.custom(error.localizedDescription)))
                    break
                    
                }
            }//end closure
    }
    
}























//class MSAPIsManager: MSAPIsManagerProtocol{
//
//func fetch<Model>(_ model:Model.Type , from networkURL:NetworkURL,
//               handler: @escaping ( (Swift.Result<Model, NetworkError>) -> Void )
//    ) where Model: Decodable, Model: Encodable {
//
//        guard let url = networkURL.url else {
//            handler(.failure(.invalidURL))
//            return
//        }
//
//        APIsManager.fetch(model.self, from: url, method: networkURL.method, params: networkURL.params, header: networkURL.header, encoding: networkURL.encoding) { [weak self] result in
//            guard self != nil else { return }
//            handler(result)
//        }
//    }
//
//}
