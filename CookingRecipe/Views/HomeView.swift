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
            VStack{
            RecipeListView(recipeViewModels: homeVM.recipeViewModels)
                }
        .edgesIgnoringSafeArea(.top)
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
