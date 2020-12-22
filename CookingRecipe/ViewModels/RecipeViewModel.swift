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
    
    @ObservedObject var imageLoader : FirebaseImageLoader
    @Published var uiImage : UIImage?
    
    var recipeP : RecipePreviewInfo {
        RecipePreviewInfo(id: recipe.id!, title: recipe.title, image: recipe.media["photo"])
    }
    
    @Injected var authService : AuthenticationService
    @Published var userId : String = "unknown"
    
    var bookmarkPath : String {
        "User/\(userId)/bookmarks"

    }
    var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    
    init(recipe: Recipe) {
        self.recipe = recipe
        self.imageLoader =  FirebaseImageLoader(recipe.media["photo"]!)
        
        // MARK: Get Thumbnail Image
        // App will crash if there is no photo string
        imageLoader.$data.map{ data in
            if let data1 = data {
                return UIImage(data: data1)
            } else {
                return nil
            }
        }
        .receive(on: DispatchQueue.main)
        .sink { [weak self] in self?.uiImage = $0 }
        .store(in: &cancellables)
        
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
