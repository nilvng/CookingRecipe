//
//  RecipeRepository.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/5/20.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class BaseRecipeRepository {
    @Published var recipes = [Recipe]()
}

protocol RecipeRepository : BaseRecipeRepository {
    //func searchRecipe(_ input: String)
}

class FirebaseRecipeRepository: BaseRecipeRepository {
        
    var db = Firestore.firestore()
    
    func loadData(){
        db.collection("Recipe").addSnapshotListener { (querySnapshot, err) in
            if let querySnapshot = querySnapshot {
                self.recipes = querySnapshot.documents.compactMap { document -> Recipe? in
                    try? document.data(as: Recipe.self)
                }
            }
        }
    }
    
    
    func addTask(_ recipe: Recipe) {
        do {
          let _ = try db.collection("Recipe").addDocument(from: recipe)
        }
        catch {
          print("There was an error while trying to save a task \(error.localizedDescription).")
        }
      }
    
    
    
    override init() {
        super.init()
        loadData()
    }
}

class TestRecipeRepository : BaseRecipeRepository {
    override init() {
        super.init()
        recipes = recipesData
    }
}
