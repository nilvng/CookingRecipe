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
                Text("*Title:").bold()
                TextField("meal title...",
                          text: $editRecipeVM.recipe.title)
            }
            
            HStack {
                Text("*Challenge:").bold()
                TextField("challenge name...",
                          text: $editRecipeVM.recipe.challenge)
            }
            
            HStack{
                Text("YouTube Video:").bold()
                TextField("embeded link...", text: $editRecipeVM.recipe.youtubeUrl)
            }

            HStack{
                Text("Attach Photo: ").bold()
                TextField("embeded link...", text: $editRecipeVM.recipe.photoUrl)

            }
            
            HStack{
                Text("Attach Video: ").bold()
                if mediaURL == nil {
                    Text("no file")
                    Button(action: {
                        self.chooseMedia.toggle()
                    }) {
                        Image(systemName:"paperclip")
                            .imageScale(.large)
                    }
                } else {
                        Text("attached")
                        Button(action: {
                            self.mediaURL = nil
                        }) {
                            Image(systemName:"trash")
                                .imageScale(.large)
                    }
                }
                
            }
            
            Divider()
            
            Button(action: {
                print("click save")
                        if isNew{
                            if let media = self.mediaURL {
                            editRecipeVM.uploadMedia(mediaURL : media)
                            } else {
                                editRecipeVM.addRecipe()
                            }
                        } else {
                            editRecipeVM.updateRecipe()
                            if mediaURL?.absoluteString != editRecipeVM.recipe.videoUrl{
                                editRecipeVM.deleteMedia()
                                editRecipeVM.uploadMedia(mediaURL : self.mediaURL)
                            }
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
            .onReceive(editRecipeVM.$recipe, perform: { recipe in
                if let videoUrl = recipe.videoUrl {
                    self.mediaURL = URL(string: videoUrl)
                }
            })
        }
    }
}

struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeView(editRecipeVM: EditRecipeViewModel(recipe: Recipe()))
    }
}
