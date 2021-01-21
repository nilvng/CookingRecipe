//
//  NavigationBarView.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/8/20.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var searchVM = SearchViewModel()
    @Environment(\.presentationMode) var presentationMode

    @State var showSearchField = false
    @State var text : String = ""
    
    var body: some View {
        GeometryReader { geo in
            
            VStack (spacing: 0){
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.backward")
                            .imageScale(.large)
                    }.padding(.bottom, 5)

                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                            .padding(6)
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
                    .background(Color(UIColor(red: 218, green: 223, blue: 232)))
                    .cornerRadius(20)
                }
                .padding(.top, geo.safeAreaInsets.top + 35)
                .padding(.horizontal)
                .padding(.bottom, 10)
                .background(Color.white)
                
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
                    .foregroundColor(.orange)
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
                        Image(systemName: "xmark").foregroundColor(.orange)
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
            .background(Color.gray)
            .cornerRadius(20)
        }
        .padding(.top, self.padValue + 30)
        .padding(.horizontal)
        .padding(.bottom, 10)
        .background(Color.white)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
