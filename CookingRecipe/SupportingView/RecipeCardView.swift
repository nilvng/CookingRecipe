//
//  RecipeCardView.swift
//  CanCookHomePage
//
//  Created by Tran Doan Dang Khoa on 02/12/2020.
//
import SwiftUI

struct RecipeCardView: View {
    // MARK: - PROPERTIES
    @ObservedObject var recipeViewModel : RecipeViewModel
    
    var body: some View {
        NavigationLink(
            destination: RecipeDetailView(recipeViewModel: recipeViewModel)){
            VStack(alignment: .center, spacing: 0) {
                // CARD IMAGE
                ImageLoaderView(withURL: recipeViewModel.recipe.photoUrl)
                    .frame(minWidth: 300, idealWidth: 300, maxWidth: .infinity, minHeight: 300, idealHeight: 450, maxHeight: .infinity, alignment: .center)
                
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


struct RecipeCardView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeCardView(recipeViewModel: RecipeViewModel(recipe: recipesData[0]))
  }
}
