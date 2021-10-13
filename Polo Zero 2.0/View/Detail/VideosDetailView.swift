//
//  VideosDetailView.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 05/07/2021.
//

import SwiftUI

struct VideosDetailView: View {
    var body: some View {
        ScrollView {
            VStack{
                Text("Massa Sela Fugas")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, 10)
                
                VideoView(videoID: "yQvF6Mi_oto")
                .frame(minHeight: 190, maxHeight: UIScreen.main.bounds.height * 0.3)
                .cornerRadius(12)
                .padding(.horizontal, 24)
                .padding(.bottom,12)
            }
            .background(Color(red: sampleProduct.red, green: sampleProduct.green, blue: sampleProduct.blue))
            .cornerRadius(12)
            
            VStack {
            Text("Anti-Humidade")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.top, 10)
            
            VideoView(videoID: "hdL5fCw7Gx0")
            .frame(minHeight: 190, maxHeight: UIScreen.main.bounds.height * 0.3)
            .cornerRadius(12)
            .padding(.horizontal, 24)
                .padding(.bottom,12)
            }
            .background(Color(red: sampleProduct.red, green: sampleProduct.green, blue: sampleProduct.blue))
            .cornerRadius(12)
            
            VStack{
                Text("Neutralizador de acidez")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, 10)
                
                VideoView(videoID: "qcin5e4PAOE")
                .frame(minHeight: 190, maxHeight: UIScreen.main.bounds.height * 0.3)
                .cornerRadius(12)
                .padding(.horizontal, 24)
                .padding(.bottom,12)
            }
            .background(Color(red: sampleProduct.red, green: sampleProduct.green, blue: sampleProduct.blue))
            .cornerRadius(12)
           
            VStack{
                Text("Sela Fugas")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, 10)
                
                VideoView(videoID: "FZ98NJJrUEQ")
                .frame(minHeight: 190, maxHeight: UIScreen.main.bounds.height * 0.3)
                .cornerRadius(12)
                .padding(.horizontal, 24)
                .padding(.bottom,12)
            }
            .background(Color(red: sampleProduct.red, green: sampleProduct.green, blue: sampleProduct.blue))
            .cornerRadius(12)
            
            VStack{
                Text("Acid Tabs")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, 10)
                
                VideoView(videoID: "FD_6jLXRAPY")
                .frame(minHeight: 190, maxHeight: UIScreen.main.bounds.height * 0.3)
                .cornerRadius(12)
                .padding(.horizontal, 24)
                .padding(.bottom,12)
            }
            .background(Color(red: sampleProduct.red, green: sampleProduct.green, blue: sampleProduct.blue))
            .cornerRadius(12)
        
            
        } //: VSTACK
    }
}

struct VideosDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VideosDetailView()
            .previewDevice("iPhone 12 Pro")
            .padding()
    }
}
