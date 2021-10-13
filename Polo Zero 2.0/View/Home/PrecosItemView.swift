//
//  PrecosItemView.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 24/06/2021.
//

import SwiftUI

struct PrecosItemView: View {
    
   // let product: Product
    let brand : Brand
    var body: some View {
        VStack(alignment: .leading, spacing: 6, content: {
            //PHOTO
            ZStack{
                Image(brand.image)
                .resizable()
                .scaledToFit()
                .padding()
                .background(Color.white.cornerRadius(12))
                .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
            }//: ZSTACK
          //  .background(Color(red: brand.red, green: brand.green, blue: brand.blue))
           // .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
            
            Spacer()
        }) //: VSTACK
    }
}

struct PrecosItemView_Previews: PreviewProvider {
    static var previews: some View {
        PrecosItemView(brand: brands[0])
            .previewLayout(.fixed(width:200, height:300))
            .padding()
            .background(colorBackground)
    }
}
