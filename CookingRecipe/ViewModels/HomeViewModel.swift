//
//  HomeViewModel.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/5/20.
//

import Foundation
import Combine
import Disk
import Resolver

class HomeViewModel: ObservableObject {
    
    @Injected var recipeRepository : RecipeRepository
    @Published var recipeViewModels = [RecipeViewModel]()

    var favRecipe = [String]()
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        
        recipeRepository.$recipes.map{ recipes in
            recipes.map{ recipe in
                return RecipeViewModel(recipe : recipe)
            }
        }
        .assign(to: \.recipeViewModels, on: self)
        .store(in: &cancellable)
    }
    
    
}
