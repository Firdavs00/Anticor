//
//  UserDefaults.swift
//  iDine
//
//  Created by Firdavs Boltayev on 09/12/21.
//

import Foundation

class UserDefault {
    
    
    func cacheToken(result: AuthResponse) {
        UserDefaults.standard.set(result.token, forKey: "token") 
   }
    func tapButton(button: Bool) {
        UserDefaults.standard.set(true, forKey: "true")
    }
    
    func getTapButton() -> Bool {
        return UserDefaults.standard.bool(forKey: "true")
    }
    
    func getToken() -> String {
        return UserDefaults.standard.string(forKey: "token") ?? ""
    }

}
