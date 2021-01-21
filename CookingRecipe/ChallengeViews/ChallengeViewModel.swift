//
//  ChallengeViewModel.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 1/21/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChallengeViewModel : ObservableObject {
    @Published var submission = [Recipe]()
    var challengeName : String
    
    var db = Firestore.firestore()
    init(_ name: String) {
        self.challengeName = name
        
        db.collection("Recipe")
            .whereField("challenge", isEqualTo: self.challengeName)
            .getDocuments() { (querySnapshot, error) in
              if let querySnapshot = querySnapshot {
                self.submission = querySnapshot.documents.compactMap { document -> Recipe? in
                  try? document.data(as: Recipe.self)
                }
              }
            }
    }
    
    func submitRecipe() -> EditRecipeViewModel{
        var recipe = Recipe()
        recipe.challenge = self.challengeName
        return EditRecipeViewModel(recipe: recipe)
    }
}
