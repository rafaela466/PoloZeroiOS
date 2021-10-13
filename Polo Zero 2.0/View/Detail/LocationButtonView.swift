//
//  LocationButtonView.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 24/06/2021.
//

import SwiftUI
import MapKit
struct LocationButtonView: View {
    
 
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 40, content: {
            
                // MARK: - LISBOA
                VStack {
                    Image("loja-lisboa")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .padding(5)
                    //  .border(Color.blue, width:12)
                        
               
                Spacer()
                    
                Text("Loja 1 - Lisboa")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("Rua Conde de Sabugosa, 27-A")
                    .fontWeight(.light)
                Text("1700-115 Lisboa")
                    .fontWeight(.light)
                Spacer()
                    
                Button(action: {}, label: {
                    Spacer()
                    Text("Abrir no GPS".uppercased())
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .onTapGesture {
                                loja1()
                        }
                    
                    Spacer()
                        
                })//: Button
                .onTapGesture {
                        loja1()
                }
                .padding(15)
                .background(
                    Color(red: sampleProduct.red, green: sampleProduct.green, blue: sampleProduct.blue)).clipShape(Capsule())
                }
                
            // MARK: - CAMARATE
            VStack {
                Image("loja-camarate")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                
                Spacer()
                Text("Loja 2 - Camarate")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("Quinta de Santa Rosa ")
                    .fontWeight(.light)
                Text("Rua Particular - Armazém 5")
                    .fontWeight(.light)
                Text("2680 - 586 Camarate")
                    .fontWeight(.light)
                Spacer()
                
                Button(action: {}, label: {
                    Spacer()
                    Text("ABRIR NO GPS".uppercased())
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .onTapGesture {
                            loja2()
                        }
                    Spacer()
                    
                })//:Button
                .padding(15)
                .background(
                    Color(red: sampleProduct.red, green: sampleProduct.green, blue: sampleProduct.blue)).clipShape(Capsule())
                }//:- VSTACK CAMARATE
            })//: - VSTACK
            .padding(.bottom,60)
        }
    }
    func loja1(){
        
            let latitude: CLLocationDegrees = 38.74828238
            let longitude: CLLocationDegrees = -9.14034887
            
            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "Polo Zero - Lisboa"
            mapItem.openInMaps(launchOptions: options)
    }

    func loja2(){
        let latitude: CLLocationDegrees = 38.79571078
        let longitude: CLLocationDegrees = -9.137535
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Polo Zero - Camarate"
        mapItem.openInMaps(launchOptions: options)
    }


}

struct LocationButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LocationButtonView()
            .previewDevice("iPhone 12 Pro")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
