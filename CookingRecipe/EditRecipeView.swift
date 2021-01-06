//
//  RecipeEditView.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 1/1/21.
//

import SwiftUI
import Firebase

struct EditRecipeView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var editRecipeVM : EditRecipeViewModel
    @State var mediaURL : URL?
    @State var isNew : Bool = true
    @State var chooseMedia : Bool = false
    var body: some View {
        VStack {
            HStack {
                Text("*Title:")
                TextField("meal title...",
                          text: $editRecipeVM.recipe.title)
            }
            
            HStack{
                Text("Attach Photo: ").bold()
                TextField("embeded link...", text: $editRecipeVM.recipe.photoUrl)
            }
            
            HStack{
                Text("YouTube Video:")
                TextField("embeded link...", text: $editRecipeVM.recipe.youtubeUrl)
            }
            
            HStack{
                Text("Attach Video: ").bold()
                Text(mediaURL != nil ? "attached" : "no file")
                Button(action: {
                    self.chooseMedia.toggle()
                }) {
                    Image(systemName: "paperclip")
                        .imageScale(.large)
                }
                
            }
            
            Divider()
            
            Button(action: {
                print("click save")
                if isNew{
                    editRecipeVM.uploadMedia(mediaURL : self.mediaURL)
                    editRecipeVM.addRecipe()
                } else {
                    editRecipeVM.updateRecipe()
                }
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("Save")
                    .padding(.vertical)
                    .padding(.horizontal,25)
                    .foregroundColor(.white)
            }
            .background(Color.red)
            .clipShape(Capsule())
            .padding()
            
            .sheet(isPresented: self.$chooseMedia){
                MediaPicker(chooseMedia: self.$chooseMedia,
                            mediaURL: self.$mediaURL)
            }
            .onReceive(editRecipeVM.$recipe) { recipe in
                mediaURL = recipe.mediaURLs
            }
        }
    }
}

struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeView(editRecipeVM: EditRecipeViewModel(recipe: CreatedRecipe(userId: "", title: "")))
    }
}
