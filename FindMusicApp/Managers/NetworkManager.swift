//
//  NetworkManager.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 25.07.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData(urlString: String, completion: @escaping ([Album]?, Error?) -> Void) {
                        
        NetworkManagerRequest.shared.setRequest(urlString: urlString) { (result) in
            
            switch result {
            case .success(let data):
                do {
                    let fetchedAlbums = try JSONDecoder().decode(MusicAlbums.self, from: data)
                    let albums = fetchedAlbums.results
                    completion(albums, nil)
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
    }
}
