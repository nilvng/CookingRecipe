//
//  BookmarkBtnView.swift
//  CookingRecipe
//
//  Created by Ngan Nguyen Bao on 12/16/20.
//

import SwiftUI
import Disk

struct BookmarkBtnView: View {
    
    @ObservedObject var bookmarkVM : BookmarkViewModel
    
    var body: some View {
        Button(action: {
            self.toFavorite()
        }) {
            if self.bookmarkVM.isFavorite {
                Image(systemName: "heart.fill")
            } else {
                Image(systemName: "heart")
            }
        }
        .foregroundColor(.pink)
        .imageScale(.large)
    }
    
    func toFavorite(){
        if self.bookmarkVM.isFavorite {
            bookmarkVM.removeSave()
        } else {
            bookmarkVM.saveRecipe()
        }
    }
}

struct BookmarkBtnView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkBtnView(bookmarkVM: BookmarkViewModel(recipe: recipesData[0]))
    }
}
