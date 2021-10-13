//
//  NavigationBarView.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 03/02/2021.
//

import SwiftUI

struct NavigationBarView: View {
    // MARK: - PROPERTIES
    @State private var isAnimated: Bool = false
    
 /*   func goLogin(){
        if let window = UIApplication.shared.windows.first{
            window.rootViewController = UIHostingController(rootView: LoginView(isPresented: .constant(true)))
            window.makeKeyAndVisible()
        }
    }*/

    func goCalc(){
        if let window = UIApplication.shared.windows.first{
            window.rootViewController = UIHostingController(rootView: BtuCalculator(isPresented: .constant(true), mostrarD: 0, mostrarE: 0, mostrarF: 0, mostrarG: 0, mostrarResultado: 0))
            window.makeKeyAndVisible()
        }
    }
    
    // MARK: - BODY
    var body: some View {
        HStack{
          
            Button(action: { goCalc() }, label: {
                Image("calculator")
                    .resizable()
                 //   .font(.title)
                   // .foregroundColor(.black)
                    .frame(width: 30, height: 30)
            })
        
            Spacer()
            
            LogoView()
                .opacity(isAnimated ? 1 : 0)
                .offset(x: 0, y: isAnimated ? 0 : -25)
                .onAppear(perform: {
                    withAnimation(.easeOut(duration: 0.5)){
                        isAnimated.toggle()
                    }
                })
                .padding(.bottom,-7)
                .padding(.top, -7)
                .padding(.trailing, 24)
            
            Spacer()
            
               /* Button(action: { }, label: {
                    Image(systemName: "plus.message")
                        .font(.title)
                        .foregroundColor(.black)
            })*/
            
        } //: - HSTACK
    } //: - BODY
}

// MARK: - PREVIEW
struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
