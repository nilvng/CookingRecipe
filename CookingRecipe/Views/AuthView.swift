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
struct AuthView: View {
    @Injected var authService : AuthenticationService
    @State private var signedIn = false
    @State private var email : String = ""
    var body: some View {
        //ZStack {
        VStack(spacing: 4) {
            Text("Name : \(authService.user?.displayName ?? "")")
            Text("Email: \(self.email)")
                .foregroundColor(.black)
            Text("UID: \(authService.user?.uid ?? "null")")
            AppView()
            //if signedIn {
            HStack{
                Button(action: {
                    do {
                        try Auth.auth().signOut()
                        self.signedIn = false
                    } catch let signOutError as NSError {
                        print ("Error signing out: %@", signOutError)
                    }
                }){
                    Text("Log Out")
                }
           // } else {
                GoogleLogin(signedIn: $signedIn)
                    .frame(width: 200, height: 30, alignment: .center)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onReceive(authService.$user){ user in
            self.email = user?.email ?? ""
        }
    }
}

struct AuthtView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}

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
            print("username in google: \(user?.profile.name)")
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
