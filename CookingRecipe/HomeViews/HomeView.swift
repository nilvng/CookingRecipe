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
    
    @State var showSearch : Bool = false
    @State var txt = ""
    var body: some View {
        NavigationView{
            GeometryReader { proxy in
                let top = proxy.safeAreaInsets.top
                
                VStack (alignment: .leading, spacing: 0){
                    HStack {
                        if !self.showSearch {
                            Text("Cookie")
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(.orange)
                        }
                        Spacer(minLength: 0)
                        
                        HStack{
                            
                            if self.showSearch{
                                
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.black)
                                        .padding(6)
                                        .cornerRadius(20)

                                    TextField("Search...", text: self.$txt, onCommit: {
                                        searchVM.localSearchFor(input: self.txt)
                                    })
                                    Button(action: {
                                        if self.txt == ""{
                                            self.showSearch.toggle()
                                        }
                                        self.txt = ""
                                    }){
                                        Image(systemName: "xmark").foregroundColor(.black)
                                    }
                                
                            }
                            else{
                                Button(action: {
                                    
                                    withAnimation {
                                        
                                        self.showSearch.toggle()
                                    }
                                    
                                }) {
                                    
                                    Image(systemName: "magnifyingglass").foregroundColor(.black).padding(6)
                                    
                                }
                            }
                        }
                        .padding(self.showSearch ? 10 : 0)
                    .background(Color(UIColor(red: 218, green: 223, blue: 232)))
                    .cornerRadius(20)
                        
                    }
                    .padding(.top, top + 15)
                                  .padding(.horizontal)
                                  .padding(.bottom, 10)
                                  .background(Color.white)
                    if txt == ""{
                RecipeListView(recipeViewModels: homeVM.recipeViewModels)
                    }
                    else {
                        ScrollView(.vertical, showsIndicators: false){
                            VStack (spacing: 15){
                                if self.homeVM.recipes.filter( {$0.title.lowercased().contains(self.txt.lowercased())}).count == 0 {
                                    Text("No Result Found").padding(.top,10)
                                } else {
                                    ForEach(self.homeVM.recipes.filter( {$0.title.lowercased().contains(self.txt.lowercased())})){ recipe in
                                        RecipeCardView(recipeViewModel: RecipeViewModel(recipe: recipe))
                                    }
                                }
                            }
                        }
                    }
                }
            .navigationTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.top)
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
