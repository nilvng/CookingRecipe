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
                        Text("CanCook")
                            .fontWeight(.bold)
                            .font(.title)
                            .italic()
                            .foregroundColor(.purple)
                        
                        Spacer(minLength: 0)
                        
                        Image("Hamburger")
                            .resizable()
                            .frame(width: 40.0, height: 40.0)
                            .padding(.horizontal, 50)
                            .rotationEffect(.init(degrees: 15))
                        
                        NavigationLink (destination: SearchView()){
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                            .padding(6)
                            .background(Color("ColorGrey"))
                            .cornerRadius(20)
                        }
                        
                    }
                    .padding(.top, top + 30)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    .background(Color.white)
                    
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
