//
//  UserView.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/11/20.
//

import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import Resolver

struct UserView: View {
    @Injected var bookmarkRepo : BookmarkRepository
    @State var bookmarks = [RecipePreviewInfo]()

    var body: some View {
        VStack (alignment: .leading, spacing: 10){
            Section {
                Text("Favorites")
                    .font(.title)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (alignment: .top, spacing: 0){
                        ForEach(self.bookmarks){ recipeP in
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
        .onReceive(bookmarkRepo.$bookmarks){bookmarks = $0}
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
