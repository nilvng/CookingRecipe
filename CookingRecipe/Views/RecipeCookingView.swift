//
//  SwiftUIView.swift
//  CanCookHomePage
//
//  Created by Tran Doan Dang Khoa on 02/12/2020.
//

import SwiftUI

struct RecipeCookingView: View {
  // MARK: - PROPERTIES
  
  var recipe: Recipe
  
  var body: some View {
    HStack(alignment: .center, spacing: 12) {
      HStack(alignment: .center, spacing: 2) {
        Image(systemName: "person.2")
        Text("Serves: \(recipe.servings)")
      }
      HStack(alignment: .center, spacing: 2) {
        Image(systemName: "clock")
        Text("Prep: \(recipe.duration)")
      }
      HStack(alignment: .center, spacing: 2) {
        Image(systemName: "flame")
        Text("Cooking: \(recipe.ingredients.count)")
      }
    }
    .font(.footnote)
    .foregroundColor(Color.gray)
  }
}

struct RecipeCookingView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeCookingView(recipe: recipesData[0])
      .previewLayout(.fixed(width: 320, height: 60))
  }
}
