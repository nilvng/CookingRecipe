//
//  HomeView.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/5/20.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var homeVM = HomeViewModel()
    
    var body: some View {
        NavigationView{
        ScrollView(.vertical, showsIndicators: true) {
         // VStack(alignment: .center, spacing: 20) {
        
            VStack(alignment: .center, spacing: 20) {
                ForEach(homeVM.recipeViewModels) { recipeVM in
                NavigationLink(
                    destination: RecipeDetailView(recipeViewModel: recipeVM)){
                    RecipeCardView(recipe: recipeVM.recipe)
              }
            }
            .frame(maxWidth: 640)
            .padding(.horizontal)
        
          //}
            }
        }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
        }
    }
}
