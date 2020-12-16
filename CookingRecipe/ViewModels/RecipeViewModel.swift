//
//  RecipeViewModel.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/5/20.
//

import Foundation
import Combine
import Disk
import SwiftUI
import Firebase


class RecipeViewModel: ObservableObject, Identifiable {
    @Published var recipe : Recipe
    @Published var isFavorite : Bool = false
    @StateObject var imageLoader : FirebaseImageLoader

    @Published var uiImage : UIImage?
    private var cancellable : AnyCancellable?
    
    init(recipe: Recipe) {
        self.recipe = recipe
        // App will crash if there is no photo string
        _imageLoader = StateObject(wrappedValue: FirebaseImageLoader(recipe.media["photo"]!))

        cancellable = imageLoader.$data.map{ data in
            if let data1 = data {
                return UIImage(data: data1)
            } else {
                return nil
            }
        }
        .receive(on: DispatchQueue.main)
        .sink { [weak self] in self?.uiImage = $0 }
    }
    
    func saveToFavorite(){
        self.isFavorite.toggle()
        var savedRecipes = [String]()
        do {
            savedRecipes = try Disk.retrieve("savedRecipes.json", from: .caches, as: [String].self)
        } catch  {
            print("Cannot get this list")
             return
        }
        if let i = savedRecipes.firstIndex(of: recipe.id!){
            savedRecipes.remove(at: i)
        } else {
            savedRecipes.append(recipe.id!)
        }
        
        do {
            try Disk.save(savedRecipes, to: .caches, as: "savedRecipes.json")
        } catch  {
            print("Cannot save to this list")
             return
        }

    }
}


final class FirebaseImageLoader : ObservableObject {
    @Published var data : Data?

    init(_ id: String){
        // the path to the image
        let url = "\(id)"
        let storage = Storage.storage()
        let ref = storage.reference().child(url)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("\(error)")
            }

            DispatchQueue.main.async {
                self.data = data
            }
        }
    }
}
