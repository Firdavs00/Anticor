//
//  OrganizationModel.swift
//  iDine
//
//  Created by Firdavs Boltayev on 09/12/21.
//

import Foundation


struct OrganizationModel: Decodable,Equatable, Identifiable, Hashable {
    
    let id: Int?
    let name: String?
}
