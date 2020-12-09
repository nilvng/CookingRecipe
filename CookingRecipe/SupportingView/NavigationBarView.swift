//
//  NavigationBarView.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/8/20.
//

import SwiftUI

struct NavigationBarView: View {
    
    @ObservedObject var searchVM = SearchViewModel()
    
    @State var showSearchField = false
    @State var text : String = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack (spacing: 0){
                
                
                RecipeListView(recipeViewModels: searchVM.recipeViewModels)
            }

        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct CustomNavView : View {
    var padValue : Int = 0
    var searchVM : SearchViewModel
    @State var showSearchField = false
    @State var text : String = ""

    var body : some View {
        HStack{
            
//            if !self.showSearchField {
//                Text("Cookie")
//                    .fontWeight(.bold)
//                    .font(.title)
//                    .foregroundColor(.white)
//            }
//
//            Spacer(minLength: 0)
            
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
            //.padding(self.showSearchField ? 10 : 0)
            .background(Color.white)
            .cornerRadius(20)
        }
        .padding(.top, (CGFloat(self.padValue) + 30))
        .padding(.horizontal)
        .padding(.bottom, 10)
        .background(Color.red)
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
    }
}
