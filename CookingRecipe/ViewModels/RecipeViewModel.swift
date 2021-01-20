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
    @Published var reviews = [Review]()
    
    var recipeP : RecipePreviewInfo {
        RecipePreviewInfo(id: recipe.id!, title: recipe.title, image: recipe.photoUrl)
    }
    
    @LazyInjected var authService : AuthenticationService
    @Published var userId : String = "unknown"
    
    var bookmarkPath : String {
        "User/\(userId)/bookmarks"

    }
    var db = Firestore.firestore()
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
    func fetchReviews() {
        let db = Firestore.firestore()
        
        db.collection("Recipe/\(recipe.id!)/review")
            .getDocuments() { (querySnapshot, err) in
                if let queryss = querySnapshot {
                    self.reviews = queryss.documents.compactMap { document -> Review? in
                        try? document.data( as: Review.self )
                    }
                }
            }

    }
    
    func existReview() -> Bool {
        let db = Firestore.firestore()
        
        db.collection("Recipe/\(recipe.id!)/review")
            .whereField("userid", isEqualTo: authService.user!.uid)
            .getDocuments() { (querySnapshot, err) in
                if let queryss = querySnapshot {
                    self.reviews = queryss.documents.compactMap { document -> Review? in
                        try? document.data( as: Review.self )
                    }
                }
            }

        return self.reviews.count > 0
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
