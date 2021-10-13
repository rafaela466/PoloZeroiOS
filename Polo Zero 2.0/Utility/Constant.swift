//
//  Constant.swift
//  Polo Zero 2.0
//
//

import SwiftUI

//DATA
let players: [Player] = Bundle.main.decode("player.json")
let catagories: [Category] = Bundle.main.decode("category.json")
let products: [Product] = Bundle.main.decode("product.json")
let brands: [Brand] = Bundle.main.decode("brand.json")
let icons: [Icon] = Bundle.main.decode("icon.json")
let sampleIcon: Icon = icons[0]
let samplePlayer: Player = players[0]
let sampleProduct: Product = products[0]
let sampleBrands: Brand = brands[0]

//COLOR
let colorBackground: Color = Color("ColorBackground")
let colorGray: Color = Color(UIColor.systemGray4)

//LAYOUT
let columnSpacing: CGFloat = 10
let rowSpacing: CGFloat = 10
var gridLayout: [GridItem]{
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
}


//UX
//API
//IMAGE
//FONT
//STRING
//MISC
