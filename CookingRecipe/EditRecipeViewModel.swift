//
//  EditRecipeViewModel.swift
//  Cloud
//
//  Created by Nil Nguyen on 1/2/21.
//  Copyright © 2021 Balaji. All rights reserved.
//

import Foundation
import Firebase
import Combine

class EditRecipeViewModel : ObservableObject {
    @Published var recipe : CreatedRecipe
    
    var recipePath = "TestCreated"
    private var db = Firestore.firestore()
    private let storage = Storage.storage().reference()
    private var cancellables = Set<AnyCancellable>()
    
    init(recipe : CreatedRecipe) {
        self.recipe = recipe
    }
    
    static func newRecipe() -> EditRecipeViewModel {
        EditRecipeViewModel(recipe: CreatedRecipe(userId: ""))
    }
    
    
    func addRecipe(){
        recipe.userId = "Nil_nhoa"
        guard let docId = self.recipe.id else {
            return
        }
        do {
            let _ = try db.collection(recipePath).document(docId).setData(from: recipe)
            print("done uploading recipe!")
        } catch {
            fatalError("Unable to encode recipe: \(error.localizedDescription).")
        }
    }
    
    func uploadMedia(mediaURL : URL?){
        guard let mediaURL1 = mediaURL else {
            return
        }
        let title =  recipe.title
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
                self.recipe.videoUrl = url.absoluteString
                self.updateRecipe()
            }
            print("done uploading file!")
        }
    }
    
    func deleteMedia(){
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
    
    func updateRecipe(){
        if let docId = recipe.id {
            do {
                let _ = try db.collection(recipePath).document(docId).setData(from: recipe)
            } catch {
                print("Unable to update recipe: \(error.localizedDescription)")
            }
        }
    }
}
