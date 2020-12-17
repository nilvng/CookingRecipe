//
//  RecipeQInfo.swift
//  CookingRecipe
//
//  Created by Ngan Nguyen Bao on 12/16/20.
//

import SwiftUI

struct RecipeAttributeView: View {
    var recipe: Recipe
    var body: some View {
        HStack (alignment: .center,
                spacing: 25){
            HStack (alignment: .center, spacing: 5){
                Image(systemName: "person")
                Text("\(recipe.servings) Servings")
            }
            Spacer(minLength: 0)
            
            HStack (alignment: .center, spacing: 5) {
                Image(systemName: "person")
                Text("\(recipe.ingredients.count) Ingredients")
            }

            Spacer(minLength: 0)
            HStack (alignment: .center, spacing: 5){
                Image(systemName: "clock")
                Text("20" + "m")
            }
        }
        .padding()
        .font(.callout)
        .foregroundColor(Color.gray)
    }
}

struct RecipeQInfo_Previews: PreviewProvider {
    static var previews: some View {
        RecipeAttributeView(recipe: recipesData[0])
    }
}



struct RecipeQuickView: View {
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

