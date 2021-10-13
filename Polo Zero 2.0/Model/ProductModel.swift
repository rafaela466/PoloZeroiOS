//
//  ProductModel.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 11/02/2021.
//

import Foundation

struct Product: Codable, Identifiable{
    let id: Int
    let name: String
    let image: String
    let imagetwo: String
    let price: String
    let description: String
    let color: [Double]
    
    var red: Double { return color[0] }
    var green: Double { return color[1] }
    var blue: Double { return color[2] }
    
    var formattedPrice: String { return "2021" }
    
}
