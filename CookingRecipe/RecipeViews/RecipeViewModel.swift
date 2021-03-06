//
//  RecipeViewModel.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/5/20.
//

import Foundation
import Combine
import Disk
import Resolver
import SwiftUI
import Firebase


class RecipeViewModel: ObservableObject, Identifiable {
    @Injected var bookmarkRepo : BookmarkRepository
    
    @Published var recipe : Recipe
    @Published var isFavorite : Bool = false
    
    var recipeP : RecipePreviewInfo {
        RecipePreviewInfo(id: recipe.id!, title: recipe.title, image: recipe.photoUrl)
    }
    private var cancellables = Set<AnyCancellable>()
    
    init(recipe: Recipe) {
        self.recipe = recipe
        
        bookmarkRepo.$bookmarks
        .receive(on: DispatchQueue.main)
            .sink { bookmarks in
                if bookmarks.contains(self.recipeP){
                    self.isFavorite = true
                }
            }
                .store(in: &cancellables)
    }
    
    func saveRecipe(){
        bookmarkRepo.saveRecipe(recipeP)
    }
    func removeSave(){
        bookmarkRepo.removeSave(recipeP)
        
    }
    
    func toFavorite(){
        self.isFavorite.toggle()
        if self.isFavorite {
            self.saveRecipe()
        } else {
            self.removeSave()
        }
    }
}
