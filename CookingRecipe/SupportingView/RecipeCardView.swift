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
    //var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
  
  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      // CARD IMAGE
        Group {
            if let uiimage = recipeViewModel.uiImage {
                Image(uiImage: uiimage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
            } else {
                Text("Loading...")
            }
        }
        .frame(minWidth: 300, idealWidth: 400, maxWidth: .infinity, minHeight: 300, idealHeight: 400, maxHeight: .infinity, alignment: .center)
      
      VStack(alignment: .leading, spacing: 10) {
        // TITLE
        HStack {
            Text(recipeViewModel.recipe.title)
              .font(.system(.title, design: .serif))
                .foregroundColor(Color.green)
                .fontWeight(.bold)
                .lineLimit(1)
            Spacer()
            
            BookmarkBtnView(bookmarkVM: BookmarkViewModel(recipe: recipeViewModel.recipe))
            
        }
        
        // HEADLINE
        Text("By \(recipeViewModel.recipe.owner)")
          .font(.system(.body, design: .serif))
            .font(.callout)
          .foregroundColor(Color.black)
          .italic()

        // RATING
//        RecipeRatingView(recipe: recipe)
        
        // COOKING
        RecipeAttributeView(recipe: recipeViewModel.recipe)
}
      .padding(.horizontal, 10)
      .padding(.bottom, 6)
    }
    .background(Color.white)
//    .cornerRadius(12)
  }
}


struct RecipeCardView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeCardView(recipeViewModel: RecipeViewModel(recipe: recipesData[0]))
  }
}

