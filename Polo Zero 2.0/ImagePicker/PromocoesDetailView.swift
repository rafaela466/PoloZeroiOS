//
//  PromocoesDetailView.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 05/07/2021.
//

import SwiftUI
import Firebase

let FILE_NAME = "daikin.png"

struct PromocoesDetailView: View {
    @State var shown = false
    @State var imageURLList = [String]()
    
    var body: some View {
        
        VStack{
            List(imageURLList, id: \.self) { item in
                ContentRow(imageURL: item)
            }
        }.onAppear(perform: listOfImageFile).animation(.spring())
       
    }
    
    func listOfImageFile() {
        let storageReference = Storage.storage().reference().child("images/")
        storageReference.listAll { (result, error) in
          if error != nil {
              // Handle any errors
              print((error?.localizedDescription)!)
              return
          }
            
          for prefix in result.prefixes {
            // The prefixes under storageReference.
            // You may call listAll(completion:) recursively on them
            print("prefix is \(prefix)")
          }
          for item in result.items {
            // The items under storageReference.
            print("items is \(item)")
            self.loadImageFromFirebase(imagePath: item.fullPath)
          }
        }
    }
    
    func loadImageFromFirebase(imagePath: String) {
        let storage = Storage.storage().reference(withPath: imagePath)
        storage.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            print("Download sucesseful")
            let urlString = "\(url!)"
            self.imageURLList.append(urlString)
        }
    }
}

struct PromocoesDetailView_Previews: PreviewProvider {
    static var previews: some View {
            PromocoesDetailView()
    }
}
