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
                    RecipeCardView(recipeViewModel: recipeVM)
                }
            }
        }
    }
}
struct RecipeCardView: View {
    // MARK: - PROPERTIES
    @ObservedObject var recipeViewModel : RecipeViewModel
    
    var body: some View {
        NavigationLink(
            destination: RecipeDetailView(recipeViewModel: recipeViewModel)){
            VStack(alignment: .center, spacing: 0) {
                // CARD IMAGE
                ImageLoaderView(withURL: recipeViewModel.recipe.photoUrl)
                    .frame(minWidth: 300, idealWidth: 300, maxWidth: .infinity, minHeight: 100, maxHeight: 450, alignment: .center)
                
                VStack(alignment: .leading, spacing: 10) {
                    // TITLE
                    HStack {
                        Text(recipeViewModel.recipe.title)
                            .font(.system(.title, design: .serif))
                            .foregroundColor(Color.green)
                            .fontWeight(.bold)
                            .lineLimit(1)
                        Spacer()
                        
                        BookmarkBtnView(recipeViewModel: recipeViewModel)
                        
                    }
                    
                    // Owner
                    
                    Text("By \(recipeViewModel.recipe.owner)")
                        .font(.system(.body, design: .serif))
                        .font(.callout)
                        .foregroundColor(Color.black)
                        .italic()
                    
                    // COOKING Attributes
                    RecipeAttributeView(recipe: recipeViewModel.recipe)
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 6)
            }
        }
        .foregroundColor(.black)
        .buttonStyle(FlatLinkStyle())
    }
}

struct RecipeListView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeListView(recipeViewModels: [RecipeViewModel(recipe: recipesData[0])])
  }
}
