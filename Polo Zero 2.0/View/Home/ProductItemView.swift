//
//  ProductItemView.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 11/02/2021.
//

import SwiftUI

struct ProductItemView: View {
    // MARK: - PROPERTY
    
    let product: Product
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 6, content: {
            //PHOTO
            ZStack{
                Image(product.imagetwo)
                    .resizable()
                    .scaledToFit()
                    .padding(10)
            }//: ZSTACK
            .background(Color(red: product.red, green: product.green, blue: product.blue))
            .cornerRadius(12)
            
            //NAME
            Text(product.name)
                .font(.title3)
                .fontWeight(.black)
            
            Spacer()
        }) //: VSTACK
    }
}

// MARK: - PREVIEW
struct ProductItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProductItemView(product: products[0])
            .previewLayout(.fixed(width:200, height:300))
            .padding()
            .background(colorBackground)
    }
}
