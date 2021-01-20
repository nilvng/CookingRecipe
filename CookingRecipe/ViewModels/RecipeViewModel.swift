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
import FirebaseFirestore

class RecipeViewModel: ObservableObject, Identifiable {
    @Injected var bookmarkRepo : BookmarkRepository
<<<<<<< HEAD

=======
    private var cancellable = Set<AnyCancellable>()
>>>>>>> review_AnhTran
    @Published var recipe : Recipe
    @Published var isFavorite : Bool = false
    @Published var reviews = [Review]()
//    @Published var reviewViewModels = [ReviewViewModel]()

    
<<<<<<< HEAD
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
=======
    @ObservedObject var imageLoader : FirebaseImageLoader
    @Published var uiImage : UIImage?
    
    var recipeP : RecipePreviewInfo {
        RecipePreviewInfo(id: recipe.id!, title: recipe.title, image: recipe.media["photo"])
    }
    
    @Injected var authService : AuthenticationService
    @Published var userId : String = "unknown"
    

    private var cancellables = Set<AnyCancellable>()
    @Published var yourReview = [Review]()
    
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
>>>>>>> review_AnhTran
            .sink { bookmarks in
                if bookmarks.contains(self.recipeP){
                    self.isFavorite = true
                }
            }
                .store(in: &cancellables)
<<<<<<< HEAD
    }
    
=======
                
        

        
    }
    
    
>>>>>>> review_AnhTran
    func saveRecipe(){
        bookmarkRepo.saveRecipe(recipeP)
    }
    func removeSave(){
        bookmarkRepo.removeSave(recipeP)
<<<<<<< HEAD
=======
        
    }
    
    func fetchReviews() {
        let db = Firestore.firestore()
>>>>>>> review_AnhTran
        
        db.collection("Recipe/\(recipe.id!)/review")
            .getDocuments() { (querySnapshot, err) in
                if let queryss = querySnapshot {
                    self.reviews = queryss.documents.compactMap { document -> Review? in
                        try? document.data( as: Review.self )
                    }
                }
            }
        self.$reviews.map{ reviews in
            reviews.map{ review in
                ReviewViewModel(review: review)
            }
        }
    }
    
    func existReview() -> Bool {
        let db = Firestore.firestore()
        
        db.collection("Recipe/\(recipe.id!)/review")
            .whereField("userid", isEqualTo: authService.user!.uid)
            .getDocuments() { (querySnapshot, err) in
                if let queryss = querySnapshot {
                    self.yourReview = queryss.documents.compactMap { document -> Review? in
                        try? document.data( as: Review.self )
                    }
                }
            }
//        self.$yourReview.map{ reviews in
//            reviews.map{ review in
//                ReviewViewModel(review: review)
//            }
//        }
        return self.yourReview.count > 0
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
    
<<<<<<< HEAD
    func toFavorite(){
        self.isFavorite.toggle()
        if self.isFavorite {
            self.saveRecipe()
        } else {
            self.removeSave()
        }
    }
}
=======

>>>>>>> review_AnhTran
