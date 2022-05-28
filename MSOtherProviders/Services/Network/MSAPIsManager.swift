//
//  MSAPIsManager.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/24/22.
//

import Alamofire
import Foundation
import Kingfisher


protocol MSNetworkRepository: AnyObject {
    func fetch<Model>(_ model:Model.Type , from networkURL:NetworkURL,
                      handler: @escaping ( (Swift.Result<Model, NetworkError>) -> Void )
    ) where Model: Decodable, Model: Encodable
}


class MSAPIsManager: MSNetworkRepository{
    
    func fetch<Model>(_ model:Model.Type , from networkURL:NetworkURL,
                      handler: @escaping ( (Swift.Result<Model, NetworkError>) -> Void )
    ) where Model: Decodable, Model: Encodable {
        
        guard let url = networkURL.url else {
            handler(.failure(.invalidURL))
            return
        }
        
        AF.request( url, method: networkURL.method, parameters: networkURL.params, encoding: networkURL.encoding, headers: networkURL.header)
            .responseData { [weak self] (response) in
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
                        print(error)
                        handler(.failure(.custom(error.localizedDescription)))
                    }
                    break
                case .failure(let error):
                    handler(.failure(.custom(error.localizedDescription)))
                    break
                    
                }
            }//end closure
    }
    
}
