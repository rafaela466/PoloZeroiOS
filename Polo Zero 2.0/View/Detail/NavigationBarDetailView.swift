//
//  NavigationBarDetailView.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 06/05/2021.
//

import SwiftUI


struct NavigationBarDetailView: View {
    // PROPERTY
    
    @EnvironmentObject var shop: Shop
    
    //BODY
    var body: some View {
        HStack{
            Button(action: {
                withAnimation(.easeIn){
                    shop.selectedProduct = nil
                    shop.showingProduct = false
                }
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(.white)
            })
            
            Spacer()
            
           /* Button(action: {}, label: {
                Image(systemName: "plus.message")
                    .font(.title)
                    .foregroundColor(.white)
            }) */
        } //: HSTACK
    }
}

struct NavigationBarDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarDetailView()
            .environmentObject(Shop())
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray)
    }
}
