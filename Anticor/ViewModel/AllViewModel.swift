//
//  OrganizationDataService.swift
//  iDine
//
//  Created by Firdavs Boltayev on 09/12/21.
//

import Foundation
import Alamofire
import SwiftUI

class ViewModel: ObservableObject {
    
    @Published var regions = [RegionModel]()
    @Published var areas = [Areas]()
    @Published var organization = [OrganizationModel]()
    @Published var summ = ""
    @Published var zayavleni = ""
    @Published var showSheet: Bool = false
    @Published var userDefault = UserDefault()
    
    func parseRegionList() {
        
        guard let url = URL(string: "https://eanticor.uz/ru/api/ref/regions/") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Content-Type" : "application/json"]
        
        URLSession.shared.dataTask(with: request) { model,  response, error in
            
            if let data = model, let response = response as? HTTPURLResponse ,
               (response.statusCode >= 200 && response.statusCode < 300) {
                
                if let decode = try? JSONDecoder().decode([RegionModel].self, from: data) {
                    DispatchQueue.main.async {
                        
                        self.regions = decode
                        print("dataaaaaaaaaaa: \(decode)")
                    }
                } else {
                    print(error ?? "")
                }
            }
        }.resume()
    }
    
    func parseRegionDetail(id: Int) {
        
        guard let url = URL(string: "https://eanticor.uz/ru/api/ref/regions/\(id)/") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Content-Type" : "application/json"]
        
        URLSession.shared.dataTask(with: request) { model,  response, error in
            
            if let data = model, let response = response as? HTTPURLResponse ,
               (response.statusCode >= 200 && response.statusCode < 300) {
                
                if let decode = try? JSONDecoder().decode(RegionModel.self, from: data) {
                    DispatchQueue.main.async {
                        guard let ares = decode.areas else {
                            return
                        }
                        self.areas = ares
                        print("model: \(self.areas)")
                    }
                } else {
                    print(error ?? "")
                }
            }
        }.resume()
    }
    
    func parseOrganizationList() {
        
        guard let url = URL(string: "https://eanticor.uz/ru/api/ref/organizations") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Content-Type" : "application/json"]
        
        URLSession.shared.dataTask(with: request) { model,  response, error in
            
            if let data = model, let response = response as? HTTPURLResponse ,
               (response.statusCode >= 200 && response.statusCode < 300) {
                
                if let decode = try? JSONDecoder().decode([OrganizationModel].self, from: data) {
                    DispatchQueue.main.async {
                        self.organization = decode
                        print("data: \(decode)")
                    }
                } else {
                    print(error ?? "")
                }
            }
            
        }.resume()
    }
    
    func sendData(cityId: Int, oblastId: Int, organId: Int,summ: Int,commentId: Int, text: String) {
        
        let headers: HTTPHeaders = [
            .authorization("Bearer " + userDefault.getToken()),
            .accept("application/json") ] // uz/api/appeal/
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append("\(cityId)".data(using: .utf8)! , withName : "region")
            multipartFormData.append("\(oblastId)".data(using: .utf8)!, withName :"area")
            multipartFormData.append("\(organId)".data(using: .utf8)!, withName :"organization")
            multipartFormData.append("\(commentId)".data(using: .utf8)!, withName :"button_type")
            multipartFormData.append("\(summ)".data(using: .utf8)!, withName :"amount")
            multipartFormData.append("\(text)".data(using: .utf8)!, withName :"text")
            multipartFormData.append("\(1)".data(using: .utf8)!, withName :"currency")
        }, to: "https://eanticor.uz/", method: .post, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    print(response.result)
                    print("Validation Successful)")
                    let decode = try? JSONDecoder().decode(Complain.self, from: response.data!)
                    print("data: \(String(describing: decode))")
                    if (decode?.appeal == "None") {
                        self.showSheet = false
                    } else {
                        self.showSheet = true
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}






