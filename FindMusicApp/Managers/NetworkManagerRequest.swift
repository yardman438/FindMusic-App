//
//  NetworkManagerRequest.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 25.07.2022.
//

import Foundation

class NetworkManagerRequest {
    
    static let shared = NetworkManagerRequest()
    
    func setRequest(urlString: String, completion: @escaping (Result<Data,Error>) -> Void) {
       
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            DispatchQueue.main.async {
                
                if error == nil, let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(error!))
                }
            }
        }.resume()
    }
}
