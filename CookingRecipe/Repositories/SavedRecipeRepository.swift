//
//  BookmarkRepository.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/16/20.
//

import Foundation
import Disk
import FirebaseFirestore
import FirebaseFirestoreSwift

class BaseSavedRecipeRepository {
    @Published var savedRecipes = [RecipePreviewInfo]()
}

protocol SavedRecipeRepository : BaseSavedRecipeRepository {

    func saveRecipe(_ recipe: RecipePreviewInfo)
    func removeSavedRecipe(_ recipe: RecipePreviewInfo)
    
}

class FirebaseSavedRecipeRepository: BaseSavedRecipeRepository, SavedRecipeRepository {
    
    var savedRecipePath : String = "User/user1/bookmarks"
    var db = Firestore.firestore()
    
    func loadData(){
        db.collection(savedRecipePath)
            .order(by: "createdTime", descending: true)
            .addSnapshotListener { (querySnapshot, err) in
            if let querySnapshot = querySnapshot {
                self.savedRecipes = querySnapshot.documents.compactMap { document -> RecipePreviewInfo? in
                    try? document.data(as: RecipePreviewInfo.self)
                }
            }
        }
    }
    
    func saveRecipe(_ recipe: RecipePreviewInfo) {
        if let docid = recipe.id {
            do {
                let _ = try db.collection(savedRecipePath).document(docid).setData(from: recipe)
            }
            catch {
                print("There was an error while trying to save a task \(error.localizedDescription).")
            }
        }
    }
    
    func removeSavedRecipe(_ recipe: RecipePreviewInfo) {
        if let docid = recipe.id {
            db.collection(savedRecipePath).document(docid).delete { (error) in
                if let error = error {
                    print("Error removing document: \(error.localizedDescription)")
                }
            }
        }
    }


    override init() {
        super.init()
        loadData()
    }
}

class LocalSavedRecipeRepository : BaseSavedRecipeRepository, SavedRecipeRepository {
    var filePath : String = "savedRecipes.json"
    
    func saveRecipe(_ recipe: RecipePreviewInfo){
        self.savedRecipes.append(recipe)
    }
    func loadData(){
        do {
            self.savedRecipes = try Disk.retrieve(filePath, from: .caches, as: [RecipePreviewInfo].self)
        } catch  {
            print("Cannot get this list")
             return
        }
    }
    
    func removeSavedRecipe(_ recipe: RecipePreviewInfo){
        
        if let i = savedRecipes.firstIndex(of: recipe){
            savedRecipes.remove(at: i)
            
        }
    }
    func writeData(){
        do {
            try Disk.save(savedRecipes, to: .caches, as: filePath)
        } catch  {
            print("Cannot save to this list")
             return
        }
        
    }

    
    override init() {
        super.init()
        loadData()
    }

}
