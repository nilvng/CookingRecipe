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
            .foregroundColor(.pink)
            .imageScale(.large)
            Text("\(recipeViewModel.isFavorite ? "yay" : "nay")")

        }
//        .onReceive(bookmarkRepo.$bookmarks){ bookmarks in
//            if bookmarks.firstIndex(of: recipeViewModel.recipeP) != nil {
//                self.isFavorite = true
//            }
//            isFavorite = bookmarkRepo.loadFavState(recipeId: recipeViewModel.recipe.id!)
//        }
//        .onAppear() {recipeViewModel.getFavState()}
    }
}

struct BookmarkBtnView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkBtnView(recipeViewModel: RecipeViewModel(recipe: recipesData[0]))
    }
}
