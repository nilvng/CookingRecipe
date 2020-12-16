//
//  BookmarkBtnView.swift
//  CookingRecipe
//
//  Created by Ngan Nguyen Bao on 12/16/20.
//

import SwiftUI
import Disk

struct BookmarkBtnView: View {
    
    @StateObject var bookmarkViewModel = BookmarkViewModel()
    var recipe : Recipe
    var recipeP : RecipePreviewInfo {
        RecipePreviewInfo(prefID: recipe.id!, title: recipe.title, image: recipe.media["photo"])
    }
    @State var isFavorite : Bool = false
    
    var body: some View {
        Button(action: {
            self.isFavorite.toggle()
            bookmarkViewModel.toFavorite(recipe: self.recipeP)
        }) {
            if self.isFavorite {
                Image(systemName: "heart.fill")
            } else {
                Image(systemName: "heart")
            }
        }
        .foregroundColor(.pink)
        .imageScale(.large)
    }
}

struct BookmarkBtnView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkBtnView(bookmarkViewModel: BookmarkViewModel(), recipe: recipesData[0])
    }
}
