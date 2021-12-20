//
//  codeToken.swift
//  WebViewSwift
//
//  Created by Firdavs Boltayev on 06/12/21.
//

import Foundation

class CodeData {
    var user = UserDefault()
    func codeToken(code: String,state: String, complation: @escaping (Data?)->Void) {
        
        guard let url = URL(string: "https://eanticor.uz/ru/api/login-one/?code=\(code)&state=\(state)") else { return }
        
        var requeset = URLRequest(url: url)
        requeset.httpMethod = "POST"
        requeset.allHTTPHeaderFields = ["Content-Type" : "application/json"]
        URLSession.shared.dataTask(with: requeset) { model, request, error in
            guard let model = model, error == nil else {
                complation(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: model)
                self.user.cacheToken(result: result)
                print("access: \(result)")
                complation(model)
            }
            catch {
                
                complation(nil)
            }
            
        }.resume()
    }
    
}
