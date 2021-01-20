//
//  EditRecipeViewModel.swift
//  Cloud
//
//  Created by Nil Nguyen on 1/2/21.
//  Copyright © 2021 Balaji. All rights reserved.
//

import Foundation
import Firebase
import Resolver

class EditRecipeViewModel : ObservableObject {
    @Published var recipe : Recipe
    @Injected var recipeRepo : RecipeRepository

    init(recipe : Recipe) {
        self.recipe = recipe
    }
    
    static func newRecipe() -> EditRecipeViewModel {
        EditRecipeViewModel(recipe: Recipe(ownerId: ""))
    }
        
    func addRecipe(){
        recipeRepo.addRecipe(recipe)
    }
    
    func updateRecipe(){
        recipeRepo.updateRecipe(recipe)
    }
    func uploadMedia(mediaURL : URL?){
        guard let mediaURL1 = mediaURL else {
            return
        }
        let title =  recipe.title
        let fileRef = Storage.storage().reference().child(title)
        
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
            recipe.videoUrl = ""
        }
    }

}
