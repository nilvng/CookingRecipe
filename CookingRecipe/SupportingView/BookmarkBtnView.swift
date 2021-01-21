//
//  BookmarkBtnView.swift
//  CookingRecipe
//
//  Created by Ngan Nguyen Bao on 12/16/20.
//

import SwiftUI
import Resolver

struct BookmarkBtnView: View {
    @ObservedObject var recipeViewModel : RecipeViewModel
    @State var isFavorite : Bool = false
    var body: some View {
        VStack {
            Button(action: {
                recipeViewModel.toFavorite()
            }) {
                if recipeViewModel.isFavorite {
                    Image(systemName: "heart.fill")
                } else {
                    Image(systemName: "heart")
                }
            }
            .foregroundColor(.orange)
            .imageScale(.large)
        }
    }
}
