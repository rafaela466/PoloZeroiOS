//
//  LoginView.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 06/09/2021.
//

import SwiftUI
import Kommunicate

struct LoginView: View {
    @Binding var isPresented: Bool
    
    @State private var isLoading = false
    @State private var userId: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    
    func goChat(){
        if let window = UIApplication.shared.windows.first{
            window.rootViewController = UIHostingController(rootView: ContentKView())
            window.makeKeyAndVisible()
        }
    }
    
    func goBack(){
        if let window = UIApplication.shared.windows.first{
            window.rootViewController = UIHostingController(rootView: ContentView().environmentObject(Shop()))
            window.makeKeyAndVisible()
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                VStack{
                Text("Tem alguma dúvida?")
                    .padding(.top, -230)
                    .font(.system(size: 26, weight: .bold, design: .default))
                    
                Text("Fale connosco!")
                    .padding(.top, -199)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    
                }.padding(.top, 40)
                
                if isLoading{
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(3)
                }
                
                Image("logo-normal")
                    .padding(.top, -190)
                    .padding(.bottom, -100)
                
                TextField(
                    "Nome (Não use espaços)",
                    text: $userId
                )
                .autocapitalization(.none)
                .padding(10)
                .border(Color.gray, width: 1)
                .padding(.bottom, -16)
                
                SecureField("Password", text: $password)
                    .padding(10)
                    .border(Color.gray, width: 1)
                    .padding(.vertical)
                
                Button("Continuar") {
                    self.login()
                    startFakeNetworkCall()
                }
                .frame(minWidth: nil, maxWidth: .infinity, minHeight: 40)
                .accentColor(.white)
                .font(.title2)
                .background(Color(red: sampleProduct.red, green: sampleProduct.green, blue: sampleProduct.blue)).clipShape(Capsule())
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Nome errado! Tente Novamente."))
                }
            }
            .padding()
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationBarTitle("Registar", displayMode: .inline)
            .navigationBarItems(leading:Button(action: { goBack() }, label: {
                    Image(systemName: "chevron.backward")
                })
            )
        }

    }
    
    func startFakeNetworkCall() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 10 ){
            isLoading = false
        }
    }

    func login() {
        let kmUser = KMUser()
        kmUser.userId = userId
        kmUser.password = password
        let appId = "2774940af2d95839a0936bbb8ab1d6589"
        Kommunicate.setup(applicationId: appId)
        Kommunicate.registerUser(kmUser) { response, error in
            guard error == nil else {
                print("[REGISTRATION] Kommunicate user registration error: %@", error.debugDescription)
                showAlert = true
                return
            }
            self.isPresented = false
            goChat()
            print("User registration was successful: %@ \(String(describing: response?.isRegisteredSuccessfully()))")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isPresented: .constant(false))
    }
}

