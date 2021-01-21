//
//  HomeViewModel.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/5/20.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestoreSwift
import Resolver

class HomeViewModel: ObservableObject {
    
    @Published var recipeViewModels = [RecipeViewModel]()
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
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
            }
        }
    }
    
}
