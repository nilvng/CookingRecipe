//
//  CookingRecipeApp.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 11/20/20.
//

import SwiftUI
import Firebase
import Resolver

@main
struct CookingRecipeApp: App {
    
    @Injected var authService : AuthenticationService
    
    init() {
        FirebaseApp.configure()
        authService.signIn()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
