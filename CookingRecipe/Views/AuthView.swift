//
//  ContentView.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 11/20/20.
//

import SwiftUI
import Firebase
import Resolver
import GoogleSignIn

struct GoogleLogin: UIViewRepresentable {
    @Binding
    var signedIn: Bool
    
    func makeUIView(context: Context) -> UIView {
//        GIDSignIn.sharedInstance.configuration?.clientID = FirebaseApp.app()?.options.clientID
//        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
//        GIDSignIn.sharedInstance().delegate = context.coordinator
        //GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        return GIDSignInButton()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        private let parent: GoogleLogin
        
        init(_ parent: GoogleLogin) {
            self.parent = parent
        }
        
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser?, withError error: Error?) {
        }
    }
}
