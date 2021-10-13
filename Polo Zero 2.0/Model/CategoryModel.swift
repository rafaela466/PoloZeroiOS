//
//  CategoryModel.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 09/02/2021.
//

import Foundation

struct Category: Codable, Identifiable{
    let id: Int
    let name: String;
    let image: String;
    let link: URL;
}
