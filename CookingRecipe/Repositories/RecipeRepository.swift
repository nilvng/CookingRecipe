//
//  RecipeRepository.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/5/20.
//

import Foundation
import Firebase
import Combine
import Resolver
import FirebaseFirestoreSwift

class BaseRecipeRepository {
    @Published var recipes = [Recipe]()
}

protocol RecipeRepository : BaseRecipeRepository{
    //func searchRecipe(_ input: String)
    func addRecipe(_ recipe: Recipe)
    func deleteRecipe(_ recipe: Recipe)
    func updateRecipe(_ recipe: Recipe)
    
}

class FirebaseRecipeRepository: BaseRecipeRepository, RecipeRepository, ObservableObject {
    
    var recipePath : String = "Recipe"
    @Published var userId = ""
    private var db = Firestore.firestore()
    private let storage = Storage.storage().reference()
    @Injected var authService : AuthenticationService
    private var cancellables = Set<AnyCancellable>()

    func loadData(){
        guard (authService.user?.email != nil && userId != "") else {
            recipes = []
            print("NO auth")
            return
        }
        db.collection(recipePath)
              .whereField("ownerId", isEqualTo: self.userId) // (9)
              .getDocuments() { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                  self.recipes = querySnapshot.documents.compactMap { document -> Recipe? in
                    try? document.data(as: Recipe.self)
                  }
                }
              }
    }

    func addRecipe(_ recipe: Recipe) {
        var recipe1 = recipe
        recipe1.ownerId = self.userId
        do {
          let _ = try db.collection(recipePath).addDocument(from: recipe1)
        }
        catch {
          print("There was an error while trying to save a task \(error.localizedDescription).")
        }
        loadData()
      }
    
    func deleteRecipe(_ recipe: Recipe) {
        if let recipeID = recipe.id {
          db.collection(recipePath).document(recipeID).delete { (error) in // (1)
            if let error = error {
              print("Error removing document: \(error.localizedDescription)")
            }
          }
        }
        loadData()
    }
    
    func updateRecipe(_ recipe: Recipe) {
        var recipe1 = recipe
        recipe1.ownerId = self.userId
        if let recipeID = recipe.id {
            do {
                try db.collection(recipePath).document(recipeID).setData(from: recipe1)
            }
            catch {
                print("There was an error while trying to save a task \(error.localizedDescription).")
            }
        }
        loadData()
      }
    
    func uploadMedia(mediaURL : URL?, recipe: Recipe){
        guard let mediaURL1 = mediaURL else {
            return
        }
        let title =  recipe.title
        var recipe1 = recipe
        let fileRef = storage.child(title)
        
        fileRef.putFile(from: mediaURL1, metadata: nil){ (meta, err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
                    print("Metadata is ... \(meta!)")

            fileRef.downloadURL {(downloadUrl, err) in
                guard let url = downloadUrl else {
                    print("cannot get downloadurl of media file")
                    return
                }
                print(url)
                recipe1.videoUrl = url.absoluteString
                self.updateRecipe(recipe1)
            }
            print("done uploading file!")
        }
    }
    
    func deleteMedia(recipe : Recipe){
        guard recipe.id != nil else {
            return
        }
        if let videoUrl = recipe.videoUrl {
            Storage.storage().reference(forURL: videoUrl).delete { err in
                if let err = err {
                    print("There is error in deleting file... \(err.localizedDescription)")
                } else {
                    print("done deleting file!")
                }
            }
        }
    }
    
    
    override init() {
        super.init()
        authService.$user
            .compactMap { user in user?.uid}
            .assign(to: \.userId, on: self)
            .store(in: &cancellables)
        
        authService.$user
            .receive(on: DispatchQueue.main)
            .sink { user in
                self.loadData()
            }
            .store(in: &cancellables)

    }
}

class TestRecipeRepository : BaseRecipeRepository {
    override init() {
        super.init()
        recipes = recipesData
    }
}
