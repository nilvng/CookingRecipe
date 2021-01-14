//
//  RecipeStore.swift
//  Cloud
//
//  Created by Nil Nguyen on 1/2/21.
//  Copyright © 2021 Balaji. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class RecipeStore : ObservableObject {
    var db = Firestore.firestore()
    var storageRef = Storage.storage()
    var userId = "Nil_nhoa"
    var recipePath = "TestCreated"
    @Published var createdRecipes = [CreatedRecipe]()
    
    init() {
        self.loadData()
    }
    
    func removeRecipe(_ recipe : CreatedRecipe){
        guard let docId = recipe.id else {
            return
        }
        if let videoUrl = recipe.videoUrl {
            storageRef.reference(forURL: videoUrl).delete { err in
                if let err = err {
                    print("There is error in deleting file... \(err.localizedDescription)")
                } else {
                    print("done deleting file!")
                }
            }
        }
        db.collection(recipePath).document(docId).delete()
    }
    
    func loadData(){
        db.collection(recipePath)
              .whereField("userId", isEqualTo: self.userId) // (9)
              .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                  self.createdRecipes = querySnapshot.documents.compactMap { document -> CreatedRecipe? in
                    try? document.data(as: CreatedRecipe.self)
                  }
                }
              }
    }
    
    func addRecipe(createdRecipe : CreatedRecipe){
        var recipe = createdRecipe
        recipe.userId = "Nil_nhoa"
        do {
        let _ = try db.collection(recipePath).addDocument(from: recipe)
        } catch {
            fatalError("Unable to encode recipe: \(error.localizedDescription).")
        }
        
    }
}

struct CreatedRecipe : Identifiable, Codable, Equatable {
    static func == (lhs: CreatedRecipe, rhs: CreatedRecipe) -> Bool {
        return lhs.id == rhs.id
    }
    
    @DocumentID var id : String? = UUID().uuidString
    var userId : String
    var title : String = ""
    var challenge : String = ""
    var photoUrl : String = ""
    var youtubeUrl : String = ""
    var videoUrl : String?
//    var duration : String
//    var ingredients: String
//    var instructions: String

}

struct MediaInfo : Codable{
    var url : String
    var contentType : String
    
}
enum FileContentType : String, Codable {
    case image
    case video
}
//let testData : [CreatedRecipe] = [
//    CreatedRecipe(id: "s1", title: "dalgona", mediaURL: URL(string: "")!, duration: "12", ingredients: "instant coffee", instructions: "whisk it")
//]
