//
//  UserDefaultsManager.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 25.07.2022.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    enum SettingKeys: String {
        case user
        case activeUser
    }
    
    let defaults = UserDefaults.standard
    let userKey = SettingKeys.user.rawValue
    let activeUserKey = SettingKeys.activeUser.rawValue
    
    var users: [User] {
        get {
            if let data = defaults.value(forKey: userKey) as? Data {
                return try! PropertyListDecoder().decode([User].self, from: data)
            } else {
                return [User]()
            }
        }
        set {
            
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: userKey)
            }
        }
    }
    
    var activeUser: User? {
        get {
            if let data = defaults.value(forKey: activeUserKey) as? Data {
                return try! PropertyListDecoder().decode(User.self, from: data)
            } else {
                return nil
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: activeUserKey)
            }
        }
    }
    
    func saveUser(firstName: String,
                  secondName: String,
                  age: Date,
                  phone: String,
                  email: String,
                  password: String) {
        
        let user = User(firstName: firstName,
                        secondName: secondName,
                        age: age, phone: phone,
                        email: email,
                        password: password)
        
        users.insert(user, at: 0)
    }
    
    func saveActiveUser(user: User) {
        
        activeUser = user
        
    }
}
