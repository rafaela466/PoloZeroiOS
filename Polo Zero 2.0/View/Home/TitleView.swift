//
//  TitleView.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 11/02/2021.
//

import SwiftUI

struct TitleView: View {
    // MARK: - PROPERTIES
    
    var title: String
    
    // MARK: - BODY
    
    var body: some View {
       HStack
       {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.heavy)
       
       Spacer()
       } //:HSTACK
       .padding(.horizontal)
       .padding(.top, 15)
       .padding(.bottom,10)
    }
}
// MARK: - PREVIEW

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "Menu")
            .previewLayout(.sizeThatFits)
            .background(colorBackground)
    }
}
