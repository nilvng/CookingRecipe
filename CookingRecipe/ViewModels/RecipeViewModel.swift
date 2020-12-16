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
    @ObservedObject var imageLoader : FirebaseImageLoader

    @Published var uiImage : UIImage?
    private var cancellable : AnyCancellable?
    
    init(recipe: Recipe) {
        self.recipe = recipe
        // App will crash if there is no photo string
        imageLoader =  FirebaseImageLoader(recipe.media["photo"]!)

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

}
