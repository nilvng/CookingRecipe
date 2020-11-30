//
//  Recipe.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 11/24/20.
//

import SwiftUI

struct Recipe: Hashable, Identifiable, Codable {
    var id: String
    var name: String
    var owner: String
    var desc: String
    var level: String
    var ingredients: [String]
    var directions: [String]
    
    var isFavorite: Bool
    
    enum Level: String, Codable, Hashable, CaseIterable {
        case easy = "Easy"
        case medium = "Medium"
        case hard = "Hard"
    }
}
