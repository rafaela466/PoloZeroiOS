//
//  QualityFavouriteDetailView.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 24/06/2021.
//

import SwiftUI

struct QualityFavouriteDetailView: View {
    // MARK: - PROPERTY
    
    // MARK: - BODY
    var body: some View {
        HStack(alignment: .center, spacing: 6, content: {
            
            Spacer()
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "heart.circle")
                    .foregroundColor(.red)
            })
        }) //: HSTACK
        .font(.system(.title, design: .rounded))
        .foregroundColor(.black)
        .imageScale(.large)
    }
}

struct QualityFavouriteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QualityFavouriteDetailView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
