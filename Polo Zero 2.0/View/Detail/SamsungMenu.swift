//
//  SamsungMenu.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 30/06/2021.
//

import SwiftUI

struct SamsungMenu: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            
            PricesList()
        }) //: VSTACK
        .zIndex(0)
        .ignoresSafeArea(.all, edges: .all)
        .navigationBarHidden(true)
    } //:BODY
} //:VIEW


struct SamsungMenu_Previews: PreviewProvider {
    static var previews: some View {
        SamsungMenu()
            .previewDevice("iPhone 12 Pro")
            .environmentObject(Shop())
            .previewLayout(.fixed(width: 375, height: 812))
    }
}
