//
//  WebService.swift
//  HotCoffee_MVVM
//
//  Created by DONGGUN LEE on 11/12/19.
//  Copyright © 2019 DONGGUN LEE. All rights reserved.
//

import Foundation

enum NetworkError:Error{
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod: String{
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Codable>{
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
}

extension Resource{
    init(url: URL){
        self.url = url
    }
}

class WebService{
    func load<T>(resource:Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void){
        
        URLSession.shared.dataTask(with: resource.url){
            data, response, error in
            
            guard let data = data, error == nil else{
                completion(.failure(.domainError))
                return
            }
            
            let result = try? JSONDecoder().decode(T.self, from: data)

            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            }
            else{
                completion(.failure(.decodingError))
            }
            
        }.resume()
        
    }
}
