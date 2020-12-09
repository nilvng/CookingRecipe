//
//  HomeViewModel.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/5/20.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var recipeRepository = FirebaseRecipeRepository()
    @Published var recipeViewModels = [RecipeViewModel]()
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        recipeRepository.$recipes.map{ recipes in
            recipes.map{ recipe in
                RecipeViewModel(recipe: recipe)
            }
        }
        .assign(to: \.recipeViewModels, on: self)
        .store(in: &cancellable)
    }
}
