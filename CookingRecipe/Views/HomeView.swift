//
//  HomeView.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/5/20.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var homeVM = HomeViewModel()
    @ObservedObject var searchVM = SearchViewModel()
    var body: some View {
        NavigationView{
            GeometryReader { proxy in
                let top = proxy.safeAreaInsets.top
                
                VStack (alignment: .leading, spacing: 0){
                    HStack {
                        Text("Cookie")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.white)
                        
                        Spacer(minLength: 0)
                        
                        NavigationLink (destination: SearchView()){
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                            .padding(6)
                            .background(Color.white)
                            .cornerRadius(20)
                        }
                    }
                    .padding(.top, top + 30)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    .background(Color.red)
                    
                RecipeListView(recipeViewModels: homeVM.recipeViewModels)
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
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
