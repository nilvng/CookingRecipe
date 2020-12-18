//
//  BookmarkViewModel.swift
//  CookingRecipe
//
//  Created by Ngan Nguyen Bao on 12/16/20.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class BookmarkViewModel : ObservableObject{
    
    //var bookmarkRepo : BookmarkRepository = FirebaseBookmarkRepository()
    var db = Firestore.firestore()
    var bookmarkPath : String = "User/user1/bookmarks"
    
    var recipe : Recipe
    var recipeP : RecipePreviewInfo {
        RecipePreviewInfo(id: recipe.id!, title: recipe.title, image: recipe.media["photo"])
    }
    @Published var isFavorite : Bool = false
    
    init(recipe : Recipe) {
        self.recipe = recipe
        
        let docRef = db.collection(bookmarkPath).document(recipe.id!)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.isFavorite = true
            }
        }
    }
    
    func saveRecipe(){
        if let docid = recipe.id {
            do {
                let _ = try db.collection(bookmarkPath).document(docid).setData(from: recipeP)
                self.isFavorite = true
            }
            catch {
                print("There was an error while trying to save a task \(error.localizedDescription).")
            }
        }
        
    }
    
    func removeSave(){
        if let docid = recipe.id {
            db.collection(bookmarkPath).document(docid).delete { (error) in
                if let error = error {
                    print("Error removing document: \(error.localizedDescription)")
                }
                self.isFavorite = true
            }
        }
    }
    
}
