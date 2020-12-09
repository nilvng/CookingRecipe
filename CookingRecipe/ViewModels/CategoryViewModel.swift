//
//  CategoryViewModel.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/8/20.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class CategoryViewModel: ObservableObject {
    
    var db = Firestore.firestore()
    
    @Published var recipesRepo = FirebaseRecipeRepository()
    @Published var result = [Recipe]()
    @Published var recipeViewModels = [RecipeViewModel]()
    
    private var cancellable = Set<AnyCancellable>()
    
    init(categoryName : String) {
        
        db.collection("Recipe").whereField("categories", arrayContains: categoryName)
            .getDocuments() { (querySnapshot, err) in
                if let queryss = querySnapshot {
                    self.result = queryss.documents.compactMap { document -> Recipe? in
                        try? document.data( as: Recipe.self )
                    }
                }
            }
        
        self.$result.map{ recipes in
            recipes.map{ recipe in
                RecipeViewModel(recipe: recipe)
            }
        }
        .assign(to: \.recipeViewModels, on: self)
        .store(in: &cancellable)
    }
    
    func findRecipeBy() {

    }

}
