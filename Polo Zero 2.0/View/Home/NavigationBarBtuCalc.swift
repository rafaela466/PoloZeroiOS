//
//  NavigationBarBtuCalc.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 06/10/2021.
//

import SwiftUI

struct NavigationBarBtuCalc: View {
    // MARK: - PROPERTIES
    
    @State private var isAnimated: Bool = false
    
    
    func goMainMenu(){
        if let window = UIApplication.shared.windows.first{
            window.rootViewController = UIHostingController(rootView: ContentView().environmentObject(Shop()))
            window.makeKeyAndVisible()
        }
    }

    
    // MARK: - BODY
    var body: some View {
        HStack{
          
            Button(action: { goMainMenu() }, label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .font(.title)
                    .foregroundColor(.black)
                    .frame(width: 20, height: 30)
            })
            Spacer()
        } //: - HSTACK
    } //: - BODY
}

struct NavigationBarBtuCalc_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarBtuCalc()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
