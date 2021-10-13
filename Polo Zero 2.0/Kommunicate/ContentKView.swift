//
//  ContentKView.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 06/09/2021.
//

import SwiftUI
import UIKit
import Kommunicate

struct ContentKView: View {
    @State private var showingLogin = false
    @State private var isLoading = false
    
    
    func startFakeNetworkCall() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 10 ){
            isLoading = false
        }
    }

    var body: some View {
        NavigationView {
            
            Button("Abrir Chat"){
                showConversation()
                startFakeNetworkCall()
            }
                .frame(minWidth: 180, minHeight: 70)
                .accentColor(.white)
                .font(.title)
                .background(Color(red: sampleProduct.red, green: sampleProduct.green, blue: sampleProduct.blue)).clipShape(Capsule())
                .navigationBarTitle("Bem-vindo!", displayMode: .inline)
                .navigationBarItems(trailing:
                        Button("Terminar") {
                            self.onSignOut()
                        }
                )
            
            if isLoading{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(3)
            }
        }//NAVI
        .onAppear(perform: initialActions)
        .sheet(isPresented: $showingLogin) {
            LoginView(isPresented: self.$showingLogin)
        }
        
    }//BODY

    func initialActions() {
        showingLogin = !KMUserDefaultHandler.isLoggedIn()
    }

    func showConversation() {
        guard let topVC = UIApplication.topViewController() else { return }
        Kommunicate.createAndShowConversation(from: topVC) { error in
            if let error = error {
                print("Error while launching: \(error.localizedDescription)")
            }
        }
    }

    
    func goBack(){
        if let window = UIApplication.shared.windows.first{
            window.rootViewController = UIHostingController(rootView: ContentView().environmentObject(Shop()))
            window.makeKeyAndVisible()
        }
    }
    
    func onSignOut() {
        Kommunicate.logoutUser { (result) in
            switch result {
            case .success(_):
                print("Logout success")
                goBack()
            case .failure( _):
                print("Logout failure, now registering remote notifications(if not registered)")
                if !UIApplication.shared.isRegisteredForRemoteNotifications {
                    UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                        if granted {
                            DispatchQueue.main.async {
                                UIApplication.shared.registerForRemoteNotifications()
                            }
                        }
                        DispatchQueue.main.async {
                            showingLogin = true
                        }
                    }
                } else {
                    showingLogin = true
                }
            }
        }
    }
}

struct ContentKView_Previews: PreviewProvider {
    static var previews: some View {
        ContentKView()
    }
}

extension UIApplication {
    class func topViewController(
        base: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
    ) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

