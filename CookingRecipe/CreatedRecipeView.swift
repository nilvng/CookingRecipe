//
//  CreatedRecipeView.swift
//  Cloud
//
//  Created by Nil Nguyen on 1/2/21.
//  Copyright © 2021 Balaji. All rights reserved.
//

import SwiftUI

struct CreatedRecipeView: View {
    
    @ObservedObject var store = RecipeStore()
    @State var show : Bool = false
    @State var editRecipeVM  = EditRecipeViewModel.newRecipe()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Text("Created")
                    Button(action: {
                        self.editRecipeVM  = EditRecipeViewModel.newRecipe()
                        self.show.toggle()
                    }) {
                        Image(systemName: "plus")
                            .resizable().frame(width: 18, height: 18).foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.red)
                    .clipShape(Circle())
                    .padding()
                }
                
                
                ForEach(store.createdRecipes) { recipe in
                    VStack {
                        NavigationLink(destination:
                                        EditRecipeView(editRecipeVM: EditRecipeViewModel(recipe: recipe),isNew: false)
                        ) {
                            HStack {
                                if recipe.photoUrl != "" {
                                    ImageLoaderView(withURL: recipe.photoUrl)
                                }
                                else if recipe.videoUrl != nil && recipe.videoUrl != ""{
                                    VideoPlayer(urlString: recipe.videoUrl!)
                                        .frame(height: 150, alignment: .center)
                                }
                                Text(recipe.title)
                                Spacer(minLength: 0)
                                Button(action : {
                                    store.removeRecipe(recipe)
                                }){
                                    Image(systemName: "trash")
                                }
                            }
                        }
                        Divider()
                    }
                }
            }
            .sheet(isPresented: self.$show){
                EditRecipeView(editRecipeVM: self.editRecipeVM)
        }
        }
    }
}



struct CreatedRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreatedRecipeView()
    }
}
