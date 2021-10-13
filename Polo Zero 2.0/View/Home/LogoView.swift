//
//  LogoView.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 03/02/2021.
//

import SwiftUI

// MARK: - PROPERTY


// MARK: - BODY

struct LogoView: View {
    var body: some View {
        HStack(spacing:4) {
            Text("Polo".uppercased())
                .font(.title2)
                .fontWeight(.black)
                .foregroundColor(.black)
            
            Image("logo-lineal")
                .resizable()
                .scaledToFit()
                .frame(width: 45, height: 45, alignment: .center)
            
            Text("Zero".uppercased())
                .font(.title2)
                .fontWeight(.black)
                .foregroundColor(.black)
        }//: HSTACK
    }
}


struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
