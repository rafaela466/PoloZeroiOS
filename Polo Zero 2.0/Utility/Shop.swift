//
//  Shop.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 24/06/2021.
//

import Foundation


class Shop: ObservableObject {
    @Published var showingProduct: Bool = false
    @Published var selectedProduct: Product? = nil //? means that its a optional property
    
    
    @Published var showingBrand: Bool = false
    @Published var selectedBrand: Brand? = nil
}
