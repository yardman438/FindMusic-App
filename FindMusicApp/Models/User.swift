//
//  User.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 25.07.2022.
//

import Foundation

struct User: Codable {
    
    let firstName: String
    let secondName: String
    let age: Date
    let phone: String
    let email: String
    let password: String
    
}
