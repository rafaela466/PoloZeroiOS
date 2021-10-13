//
//  ContentRow.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 08/07/2021.
//

import SwiftUI
import Firebase

let userScale:CGFloat = 40
let bottomButtonScale:CGFloat = 30

struct ContentRow: View {
    @State var imageURL = ""
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                if imageURL != "" {
                    FirebaseImageView(imageURL: imageURL)
                }
            }
        }
    }
}


struct ContentRow_Previews: PreviewProvider {
    static var previews: some View {
        ContentRow()
    }
}
