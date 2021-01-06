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
                                if let thumbnail = recipe.photoUrl{
                                            ImageLoaderView(withURL: thumbnail)
                                } else if let story = recipe.videoUrl {
                                            VideoPlayer(urlString: story)
                                        }
                                Text(recipe.title)
                                Spacer(minLength: 0)
                                Button(action : {
                                    store.removeRecipe(recipe.id!)
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
