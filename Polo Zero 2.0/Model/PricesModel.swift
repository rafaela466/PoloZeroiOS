//
//  PricesModel.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 30/06/2021.
//

import Foundation

let getUrlTwo = "https://api.npoint.io/20ce2aa1e547b10e734a"
let postUrlTwo = "https://jsonplaceholder.typicode.com/posts"

struct ListaPrecos: Decodable{
    let id: Int
    let marca: String
    let imageUrl: String
    let ano: String
    let link: URL
}

struct PostingPrecos: Decodable{
    let id: Int
    let marca: String
    let imageUrl: String
    let link: URL
    let ano: String
    let body: String
}


