//
//  MusicAlbum.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 25.07.2022.
//

import Foundation

struct MusicAlbums: Decodable {
    
    let results: [Album]
    
}

struct Album: Decodable {
    
    let artistName: String
    let collectionName: String
    let collectionViewUrl: String?
    let artworkUrl100: String?
    let trackCount: Int
    let releaseDate: String
    let primaryGenreName: String
    
}
