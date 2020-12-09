//
//  SearchViewModel.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/8/20.
//


import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class SearchViewModel: ObservableObject {
    
    var db = Firestore.firestore()
    
    @Published var recipesRepo = FirebaseRecipeRepository()
    @Published var result = [Recipe]()
    @Published var recipeViewModels = [RecipeViewModel]()
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        self.$result.map{ recipes in
            recipes.map{ recipe in
                RecipeViewModel(recipe: recipe)
            }
        }
        .assign(to: \.recipeViewModels, on: self)
        .store(in: &cancellable)
    }
    
    func fbSearchFor(input : String){
        db.collection("Recipe").whereField("title", isEqualTo: input)
            .getDocuments() { (querySnapshot, err) in
                if let queryss = querySnapshot {
                    self.result = queryss.documents.compactMap { document -> Recipe? in
                        try? document.data( as: Recipe.self )
                    }
                
                }
            }
    }
    
    func localSearchFor(input : String){
        if input != ""{
            self.result = recipesRepo.recipes
                .filter({
                    $0.title.lowercased().contains(input.lowercased())
                })
        }
    }
}
