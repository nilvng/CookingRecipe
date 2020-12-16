//
//  UserRepository.swift
//  CookingRecipe
//
//  Created by Ngan Nguyen Bao on 12/16/20.
//

import Foundation



class UserSettings: ObservableObject {
  
    private init() { }
    // Singleton
    static let shared = UserSettings()
  
    @Published var score = 0
}
