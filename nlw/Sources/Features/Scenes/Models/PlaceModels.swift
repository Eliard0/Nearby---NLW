//
//  PlaceModels.swift
//  nlw
//
//  Created by Eliardo Venancio on 13/12/24.
//

import Foundation

struct Place: Decodable {
    let id: String
    let name: String
    let description: String
    let coupons: Int
    let latitude: Double
    let longetide: Double
    let address: String
    let phone: String
    let cover: String
    let categoryId: String    
}
