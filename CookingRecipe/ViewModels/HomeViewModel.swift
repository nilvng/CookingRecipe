//
//  HomeViewModel.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/5/20.
//

import Foundation
import Combine
<<<<<<< HEAD
import Firebase
import FirebaseFirestoreSwift
=======
import Disk
>>>>>>> review_AnhTran
import Resolver

class HomeViewModel: ObservableObject {
    
<<<<<<< HEAD
=======
    @Injected var recipeRepository : RecipeRepository
>>>>>>> review_AnhTran
    @Published var recipeViewModels = [RecipeViewModel]()
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
<<<<<<< HEAD
        loadData()
    }
    func loadData(){
        let db = Firestore.firestore()
        let recipePath = "Recipe"
        db.collection(recipePath).addSnapshotListener { (querySnapshot, err) in
            if let querySnapshot = querySnapshot {
                let recipes = querySnapshot.documents.compactMap { document -> Recipe? in
                    try? document.data(as: Recipe.self)
                }
                
                self.recipeViewModels = recipes.map{ recipe in
                    RecipeViewModel(recipe: recipe)
                }
=======
        
        recipeRepository.$recipes.map{ recipes in
            recipes.map{ recipe in
                return RecipeViewModel(recipe : recipe)
>>>>>>> review_AnhTran
            }
        }
    }
    
}
