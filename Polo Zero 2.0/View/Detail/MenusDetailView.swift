//
//  MenusDetailView.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 01/07/2021.
//

import SwiftUI

struct MenusDetailView: View {
    @EnvironmentObject var shop: Shop
    var body: some View {
        HStack(alignment: .center, spacing: 6, content: {
            Image(shop.selectedProduct?. ?? sampleProduct.image)
                .resizable()
                .scaledToFit()
        })//: HSTACK
    }
}

struct MenusDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MenusDetailView()
                .environmentObject(Shop())
    }
}
