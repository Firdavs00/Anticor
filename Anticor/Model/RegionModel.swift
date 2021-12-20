//
//  FegionModel.swift
//  iDine
//
//  Created by Firdavs Boltayev on 10/12/21.
//

import Foundation


struct RegionModel: Decodable,Equatable, Identifiable, Hashable {
    
    var id: Int?
    var name: String?
    var areas: [Areas]?
    
}
struct Areas: Decodable,Equatable, Identifiable, Hashable {
    
    var id: Int?
    var name: String?
}
