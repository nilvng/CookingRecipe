//
//  RecipeDetail.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 11/23/20.
//

import SwiftUI
import Foundation

struct RecipeDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var startCooking = false
    @ObservedObject var recipeViewModel : RecipeViewModel
    @State var viewReview: Bool = false
    @State var createReview = false
    @State var editReview = false
    @State var view1Review: Bool = false
    var body: some View {
            //List{
            ScrollView(.vertical, showsIndicators: false) {
                VStack (alignment: .leading) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.backward")
                            .imageScale(.large)
                    }.padding(.bottom, 5).padding(.horizontal, 10)
                    Group {
                        HStack {
                            Text(recipeViewModel.recipe.title)
                                .font(.title)
                                .bold()
                            
                            Spacer()
                            
                            BookmarkBtnView(recipeViewModel: recipeViewModel)
                        }
                        // OWNER
                        Text("by \(recipeViewModel.recipe.owner)")
                            .font(.body)
                    }
                    .padding(.horizontal, 10)
                    // meal's media
                    let videoURL = recipeViewModel.recipe.media["video"]
                    if videoURL != nil && videoURL != ""{
                            WebView(url: videoURL!)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 500, maxHeight: .infinity, alignment: .center)
                    } else {
                        Group {
                            if let uiimage = recipeViewModel.uiImage {
                                Image(uiImage: uiimage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } else {
                                Text("Loading...")
                            }
                        }
                        .frame(minWidth: 300, idealWidth: 400, maxWidth: .infinity, minHeight: 300, idealHeight: 400, maxHeight: .infinity, alignment: .center)
                    }
                    // QLOOK
                    RecipeAttributeView(recipe: recipeViewModel.recipe)
                    // INGREDIENTS
                    IngredientsList(ingredients: recipeViewModel.recipe.ingredients)
                    // DIRECTION
                    Text("Directions")
                        .bold()
                        .font(.title2)
                        .padding(.horizontal, 7)
                        .padding(.bottom, 5)
                    // Modal sbs
                    Button(action: {
                        self.startCooking.toggle()
                    }){
                        Text("Start Cooking")
                            .font(.subheadline)
                        Image(systemName: "play")
                            
                    }
                    .padding(.vertical,7)
                    .padding(.horizontal, 120)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(7)
                    .frame(maxWidth: .infinity)
                    
                    DirectionsList(steps: recipeViewModel.recipe.instructions)
                    Group {
                        HStack {
                            Text("Reviews")
                                .bold()
                                .font(.title2)
                            Spacer()
                            Button(action: { self.viewReview.toggle() }) {
                                Image(systemName: viewReview ? "icloud" : "icloud.fill")
                            }
                            Button(action: { self.createReview.toggle() }) {
                                Image(systemName: createReview ? "bolt.slash.circle" : "plus.circle")
                            }
                            Button(action: { self.editReview.toggle()}) {
                                Image(systemName: editReview ? "pencil" : "pencil.circle")
                            }
                            // .disabled(!recipeViewModel.existReview())
                            Button(action: { self.view1Review.toggle() }) {
                                Image(systemName: view1Review ? "icloud" : "icloud.fill")
                            }
                        }
                        if createReview {
                            CreateReview(exist: recipeViewModel.existReview())
                        }
                        else if editReview {
                            EditOneReview(exist: recipeViewModel.existReview())
                        }
                        else if view1Review{
                            OneReviewView(exist: recipeViewModel.existReview())
                        }
                        
                            else {
                            if viewReview {
                                ReviewView()
                            }
                        }
                    }
                }
            }
        
            .onAppear(perform: {
                ReviewRepository.shared.recipeId = recipeViewModel.recipe.id
            })
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipeViewModel: RecipeViewModel(recipe: recipesData[0]))    }
}

struct IngredientsList: View {
    var ingredients: [String]
    var body: some View {
        Text("Ingredients")
            .bold()
            .font(.title2)
            .padding(.horizontal, 7)
            .padding(.bottom, 5)

            ForEach(ingredients, id: \.self) { item in
                HStack {
                    Text(item)
//                    Spacer()
//                    Text("1 pack")
//                        .bold()
                }
                .padding(.horizontal, 10)
                Divider()
            }
    }
}
