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
            } else {
                Text("Loading...")
            }
        }
        .frame(minWidth: 300, idealWidth: 400, maxWidth: .infinity, minHeight: 300, idealHeight: 400, maxHeight: .infinity, alignment: .center)
      
      VStack(alignment: .leading, spacing: 12) {
        // TITLE
        HStack {
            Text(recipeViewModel.recipe.title)
              .font(.system(.title, design: .serif))
                .foregroundColor(Color.blue)
                .fontWeight(.bold)
                .lineLimit(1)
            Spacer()
            
            Button(action: {
                recipeViewModel.saveToFavorite()
                
            }) {
                if recipeViewModel.isFavorite {
                    Image(systemName: "heart.fill")
                } else {
                    Image(systemName: "heart")
                }
            }
            .foregroundColor(.pink)
            .imageScale(.large)


        }
        
        // HEADLINE
        Text("By \(recipeViewModel.recipe.owner)")
          //.font(.system(.body, design: .serif))
            .font(.callout)
          .foregroundColor(Color.gray)
          .italic()

        // RATING
//        RecipeRatingView(recipe: recipe)
        
        // COOKING
        RecipeQLook(recipe: recipeViewModel.recipe)
}
      .padding(.horizontal, 4)
      .padding(.bottom, 6)
    }
    .background(Color.white)
//    .cornerRadius(12)
  }
}


//struct RecipeCardView_Previews: PreviewProvider {
//  static var previews: some View {
//    RecipeCardView(recipe: recipesData[0])
//        .previewLayout(.device)
//  }
//}

