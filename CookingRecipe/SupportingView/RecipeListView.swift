//
//  RecipeListView.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/8/20.
//

import SwiftUI

struct RecipeListView: View {
    var recipeViewModels : [RecipeViewModel]
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .center, spacing: 10) {
                ForEach(recipeViewModels) { recipeVM in
                    NavigationLink(
                        destination: RecipeDetailView(recipeViewModel: recipeVM)){
                        RecipeCardView(recipeViewModel: recipeVM)
                    }
                    .foregroundColor(.black)
                    .buttonStyle(FlatLinkStyle())
            }
          }
        }
    }
}
