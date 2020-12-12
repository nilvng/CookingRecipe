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
    
    @Published var recipeRepository = FirebaseRecipeRepository()
    @Published var recipeViewModels = [RecipeViewModel]()

    var favRecipe = [Recipe]()
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        
        do {
            favRecipe = try Disk.retrieve("savedRecipes.json", from: .caches, as: [Recipe].self)
        } catch  {
            print("error from getting saved recipes")
        }
        
        recipeRepository.$recipes.map{ recipes in
            recipes.map{ recipe in
                if self.favRecipe.contains(recipe){
                return RecipeViewModel(recipe : recipe)
                }
                return RecipeViewModel(recipe : recipe)

            }
        }
        .assign(to: \.recipeViewModels, on: self)
        .store(in: &cancellable)
    }
    
    
}
