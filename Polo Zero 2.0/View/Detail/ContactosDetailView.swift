//
//  ContactosDetailView.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 05/07/2021.
//

import SwiftUI

struct ContactosDetailView: View {
    @Environment(\.openURL) var openURL
    var body: some View {
        ScrollView{
        VStack( spacing: 15, content: {
            VStack(){
            Text("Telefone Geral 1:")
                .font(.title3)
                .fontWeight(.bold)
            Link("(+351) 218 437 400", destination: URL(string: "tel:351218437400")!)
                
            }
            
            VStack(){
            Text("Telefone Geral 2:")
                .font(.title3)
                .fontWeight(.bold)
            Link("(+351) 933 849 649", destination: URL(string: "tel:351933849649")!)
            }
            
            VStack(){
            Text("Telefone Geral 3:")
                .font(.title3)
                .fontWeight(.bold)
            Link("(+351) 932 034 497", destination: URL(string: "tel:351932034497")!)
            }
            
            VStack(){
            Text("E-mail:")
                .font(.title3)
                .fontWeight(.bold)
            Link("info@polozero.com", destination: URL(string: "mailto:info@polozero.com")!)
                }
            })//: VSTACK
        .padding(.bottom, 39)
            
            Text("Consulte o nosso horário!")
                .font(.title2)
                .bold()
                .padding(.bottom, 5.8)
            
            Button(action: {}, label: {
                Spacer()
                Text("www.polozero.com".uppercased())
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .onTapGesture {
                        openURL(URL(string: "https://www.polozero.com/contactos")!)
                    }
                Spacer()
                    
            })//: Button
            .onTapGesture {
                openURL(URL(string: "https://www.polozero.com")!)
            }
            .padding(15)
            .background(Color(red: sampleProduct.red, green: sampleProduct.green, blue: sampleProduct.blue)).clipShape(Capsule())
        }//: SCROLLVIEW
    }
}

struct ContactosDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContactosDetailView()
            .previewDevice("iPhone 12 Pro")
            .padding()
    }
}
