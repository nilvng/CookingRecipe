//
//  RecipeRatingView.swift
//  CanCookHomePage
//
//  Created by Tran Doan Dang Khoa on 02/12/2020.
//

import SwiftUI

struct RecipeRatingView: View {
  // MARK: - PROPERTIES
  
  var recipe: Recipe
  
  var body: some View {
    HStack(alignment: .center, spacing: 5) {
//      ForEach(1...(recipe.rating), id: \.self) { _ in
//        Image(systemName: "star.fill")
//          .font(.body)
//          .foregroundColor(Color.yellow)
//      }
    }
  }
}

struct RecipeRatingView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeRatingView(recipe: recipeData[0])
      .previewLayout(.fixed(width: 320, height: 60))
  }
}
