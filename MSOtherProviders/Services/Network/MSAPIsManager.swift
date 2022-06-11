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
    
    func upload<Model>(_ images:[(name:String, image:Data)],
                       _ model:Model.Type ,
                       from networkURL:NetworkURL,
                       handler: @escaping ( (Swift.Result<Model, NetworkError>) -> Void )
    ) where Model: Decodable, Model: Encodable
}


class MSAPIsManager: MSNetworkRepository{
    
    var networkManager:NetworkReachabilityManager?
    
    init(nReachabilityManager:NetworkReachabilityManager? = NetworkReachability()) {
        networkManager = nReachabilityManager
    }
    
    // MARK: - MSAPIsManager fetch -
    func fetch<Model>(_ model:Model.Type , from networkURL:NetworkURL,
                      handler: @escaping ( (Swift.Result<Model, NetworkError>) -> Void )
    ) where Model: Decodable, Model: Encodable {
        
        if let nm = networkManager, !nm.isReachable {
            handler(.failure(.errorConnection))
            return
        }
        
        guard let url = networkURL.url else {
            handler(.failure(.invalidURL))
            return
        }
        
        AF.request( url, method: networkURL.method, parameters: networkURL.params, encoding: networkURL.encoding, headers: networkURL.header)
            .responseString { [weak self] (response) in
                guard self != nil else { return }
                switch response.result {
                case .success(let data):
                    print(data)
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
                    print(error)
                    handler(.failure(.custom(error.localizedDescription)))
                    break
                    
                }
            }//end closure
    }
    
    
    // MARK: - MSAPIsManager upload -
    func upload<Model>(_ images:[(name:String, image:Data)],
                       _ model:Model.Type ,
                       from networkURL:NetworkURL,
                       handler: @escaping ( (Swift.Result<Model, NetworkError>) -> Void )
    ) where Model: Decodable, Model: Encodable {
        
        if let nm = networkManager, !nm.isReachable {
            handler(.failure(.errorConnection))
            return
        }
        
        guard let url = networkURL.url else {
            handler(.failure(.invalidURL))
            return
        }
        
        AF.upload(
            multipartFormData: { [weak self] (multipartFormData) in
                guard self != nil else { return }
                images.forEach({
                    multipartFormData.append($0.image, withName: $0.name, fileName: "\($0.name).png", mimeType: "image/png")
                })
                networkURL.params?.forEach({
                    multipartFormData.append( "\($0.value)".data(using: .utf8)! , withName: $0.key)
                })
            },
            to: url,
            method: networkURL.method,
            headers: networkURL.header
        ).responseData { [weak self] (response) in
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
                print(error)
                handler(.failure(.custom(error.localizedDescription)))
                break
                
            }
        }//end closure
    }
    
}

