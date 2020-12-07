//
//  RecipeViewModel.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/5/20.
//

import Foundation
import Combine


class RecipeViewModel: ObservableObject, Identifiable {
    @Published var recipe : Recipe

    init(recipe: Recipe) {
        self.recipe = recipe
    }
}
