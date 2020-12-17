//
//  HomeViewModel.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/5/20.
//

import Foundation
import Combine
import Disk

class HomeViewModel: ObservableObject {
    
    @Published var recipeRepository : RecipeRepository = FirebaseRecipeRepository()
    @Published var recipeViewModels = [RecipeViewModel]()

    var favRecipe = [String]()
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        
        do {
            favRecipe = try Disk.retrieve("savedRecipes.json", from: .caches, as: [String].self)
        } catch  {
            print("error from getting saved recipes")
        }
        
        recipeRepository.$recipes.map{ recipes in
            recipes.map{ recipe in
                if self.favRecipe.contains(recipe.id ?? "noid"){
                let rVM = RecipeViewModel(recipe : recipe)
                    rVM.isFavorite = true
                    return rVM
                }
                return RecipeViewModel(recipe : recipe)

            }
        }
        .assign(to: \.recipeViewModels, on: self)
        .store(in: &cancellable)
    }
    
    
}
