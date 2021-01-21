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
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        GIDSignIn.sharedInstance().delegate = context.coordinator
        //GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        return GIDSignInButton()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, GIDSignInDelegate {
        private let parent: GoogleLogin
        
        init(_ parent: GoogleLogin) {
            self.parent = parent
        }
        
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser?, withError error: Error?) {
            guard let authentication = user?.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
            let  currentUser = Auth.auth().currentUser
            if currentUser != nil && currentUser?.isAnonymous == false {
                print("about to link...")
                currentUser?.link(with: credential) { (authResult, error) in
                    self.parent.signedIn = true
                    if let error = error {
                        print("error in linking auth \(error.localizedDescription)")
                    }
                }
            } else {
                Auth.auth().signIn(with: credential) { (authResult, error) in
                    self.parent.signedIn = true
                    if let error = error {
                        print("error in linking auth \(error.localizedDescription)")
                    }
                }
            }
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = user?.profile.name
            changeRequest?.commitChanges { (error) in
              // ...
            }
            func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
            }
        }
    }
}
