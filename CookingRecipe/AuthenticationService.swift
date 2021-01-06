//
//  AuthenticationService.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/21/20.
//

import Foundation
import Firebase

class AuthenticationService : ObservableObject {
    @Published var user : User?
    
    init() {
        registerStateListener()
    }
    
    func signIn(){
        if Auth.auth().currentUser == nil{
            Auth.auth().signInAnonymously()
        }
    }
    
    private func registerStateListener (){
        Auth.auth().addStateDidChangeListener { (auth, user) in
                print("Listen for auth status")
                self.user = user
            //user?.providerData[0]
                if let user = user {
                  let anonymous = user.isAnonymous ? "anonymously " : ""
                  print("User signed in \(anonymous)with user ID \(user.uid).")
                    print("username: \(user.displayName)")
                    print("mail: \(user.email)")

                }
                else {
                  print("User signed out.")
                }

        }
        }
    }
//}
