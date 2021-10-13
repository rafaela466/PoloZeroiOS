//
//  FooterView.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 03/02/2021.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("www.polozero.com | info@polozero.com")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .layoutPriority(2)
               
            Image("logo-pz")
                .layoutPriority(0)
        
        Text("Copyright @ Polo Zero Lda.")
            .font(.footnote)
            .fontWeight(.bold)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .layoutPriority(1)
        }//: VSTACK
        .padding()
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
            .previewLayout(.sizeThatFits)
            .background(colorBackground)
    }
}
