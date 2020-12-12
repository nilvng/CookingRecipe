//
//  RecipeViewModel.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/5/20.
//

import Foundation
import Combine
import Disk
import SwiftUI


class RecipeViewModel: ObservableObject, Identifiable {
    @Published var recipe : Recipe
    @Published var isFavorite : Bool = false
    
    init(recipe: Recipe) {
        self.recipe = recipe
}
    func saveToFavorite(){
        do {
            try Disk.append(recipe, to: "savedRecipes.json", in: .caches)
        } catch  {
            print("Cannot save this recipe")
        }
    }
}
