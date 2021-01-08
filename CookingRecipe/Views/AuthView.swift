//
//  ContentView.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 11/20/20.
//

import SwiftUI
import Firebase
import GoogleSignIn
import Resolver
import Combine
struct AuthView: View {
    @AppStorage("userid") public static var userid = ""
    @AppStorage("emails") public static var emails = ""
    @AppStorage("userNAME") public static var userNAME = ""
    @State
    private var signedIn = false
    @State
    private var username: String = ""
    @State
    private var email: String = ""
    @State
    private var uid: String = ""
    var body: some View {
        ZStack {
            Color.white
            if signedIn {
                VStack(spacing: 4) {

                    
                    Text("Email: \(email)")
                        .foregroundColor(.black)
                    Text("UID: \(uid)")
                    Text("Username: \(username)")
                        .foregroundColor(.black)
                    Text("\(AuthView.userid)")
                    AppView()
                    GoogleLogout(signedIn: $signedIn)
                        .frame(width: 200, height: 30, alignment: .center)

                }
                .onAppear(perform: saveuserID)
            } else {
                GoogleLogin(signedIn: $signedIn, username: $username, email: $email, uid: $uid)
                    .frame(width: 200, height: 30, alignment: .center)
            }
        }.edgesIgnoringSafeArea(.all)
    }
    func saveuserID(){
        AuthView.userid = uid
        AuthView.userNAME = username
        AuthView.emails = email
    }
}

struct AuthtView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
struct GoogleLogout: UIViewRepresentable {
    @Binding
    var signedIn: Bool

    func makeUIView(context: Context) -> UIView {
        GIDSignIn.sharedInstance().delegate = context.coordinator

        let button = UIButton(frame: .zero)
        button.setTitle("Logout", for: .normal)
        button.backgroundColor = UIColor.red
        button.addTarget(context.coordinator, action: #selector(Coordinator.onLogout), for: .touchUpInside)
        return button
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, GIDSignInDelegate {
        private let parent: GoogleLogout

        init(_ parent: GoogleLogout) {
            self.parent = parent
        }

        @objc
        func onLogout(button: UIButton) {
            GIDSignIn.sharedInstance()?.disconnect()
        }

        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser?, withError error: Error?) {
        }

        func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
            parent.signedIn = false
        }
    }
}


struct GoogleLogin: UIViewRepresentable {
    @Binding
    var signedIn: Bool
    @Binding
    var username: String
    @Binding
    var email: String
    @Binding
    var uid: String

    func makeUIView(context: Context) -> UIView {
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        GIDSignIn.sharedInstance().delegate = context.coordinator
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()

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

            Auth.auth().currentUser?.link(with: credential) { (authResult, error) in
                self.parent.signedIn = true
                if let username = authResult?.user.displayName {
                    self.parent.username = username
                }
                if let email = authResult?.user.email {
                    self.parent.email = email
                }
                if let uid = authResult?.user.uid {
                    self.parent.uid = uid
                }
            }
        }

        func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        }
    }
}
