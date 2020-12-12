//
//  NavigationBarView.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/8/20.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var searchVM = SearchViewModel()
    
    @State var showSearchField = false
    @State var text : String = ""
    
    var body: some View {
        GeometryReader { geo in
            
            VStack (spacing: 0){
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                            .padding(6)
                            .background(Color.white)
                            .cornerRadius(20)

                        TextField("Search...", text: self.$text, onCommit: {
                            searchVM.localSearchFor(input: self.text)
                        })
                        Button(action: {
                            self.text = ""
                        }){
                            Image(systemName: "xmark").foregroundColor(.black)
                        }
                    }
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(20)
                }
                .padding(.top, geo.safeAreaInsets.top + 35)
                .padding(.horizontal)
                .padding(.bottom, 10)
                .background(Color.red)
                
                if searchVM.recipeViewModels.count == 0{
                    Text("No result")
                } else {
                RecipeListView(recipeViewModels: searchVM.recipeViewModels)
                }
            }

        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct CustomNavView : View {
    var padValue : CGFloat = 0
    var searchVM : SearchViewModel
    @State var showSearchField = false
    @State var text : String = ""

    var body : some View {
        HStack{
            
            if !self.showSearchField {
                Text("Cookie")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
            }

            Spacer(minLength: 0)
            
            HStack{
                if self.showSearchField {
                    Image("search")
                        .resizable()
                        .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                    TextField("Search Food", text: self.$text, onCommit: {
                        searchVM.localSearchFor(input: self.text)
                    })
                    Button(action: {
                        withAnimation {
                            self.showSearchField.toggle()
                    }
                    }){
                        Image(systemName: "xmark").foregroundColor(.black)
                    }
                } else {
                    Button(action: {
                        withAnimation {
                            self.showSearchField.toggle()
                        }
                    }) {
                        Image("search")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.black)
                            .padding(6)
                        
                    }

                }
            }
            .padding(self.showSearchField ? 10 : 0)
            .background(Color.white)
            .cornerRadius(20)
        }
        .padding(.top, self.padValue + 30)
        .padding(.horizontal)
        .padding(.bottom, 10)
        .background(Color.red)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
