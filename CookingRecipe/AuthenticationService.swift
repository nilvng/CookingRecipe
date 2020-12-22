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
    
    func signIn(){
        registerStateListener()
        Auth.auth().signInAnonymously()
    }
    
    private func registerStateListener (){
        Auth.auth().addStateDidChangeListener { (auth, user) in // (4)
          print("Sign in state has changed.")
          self.user = user
          
          if let user = user {
            let anonymous = user.isAnonymous ? "anonymously " : ""
            print("User signed in \(anonymous)with user ID \(user.uid).")
          }
          else {
            print("User signed out.")
          }
        }
    }
}
