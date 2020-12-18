//
//  UserView.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/11/20.
//

import SwiftUI

struct UserView: View {
    var favoriteRecipe : BookmarkRepository = FirebaseBookmarkRepository()
    var body: some View {
        VStack (alignment: .leading, spacing: 10){
            Section {
                Text("Favorites")
                    .font(.title)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (alignment: .top, spacing: 0){
                        ForEach(favoriteRecipe.bookmarks){ recipeP in
                            VStack (alignment: .center, spacing: 10) {
                                FirebaseImageView(id: recipeP.image ?? "")
                                    .frame(width: 150, height: 150)
                                Text(recipeP.title)

                            }
                        }
                    }
                }
            }
            
            Text("Created")
                .font(.title)
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
