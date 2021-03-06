//
//  RecipeDetail.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 11/23/20.
//

import SwiftUI
import Foundation

struct RecipeDetailView: View {
    
    @State var startCooking = false
    @ObservedObject var recipeViewModel : RecipeViewModel

    var body: some View {
            //List{
            ScrollView(.vertical, showsIndicators: false) {
                VStack (alignment: .leading) {
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
                    let videoURL = recipeViewModel.recipe.youtubeUrl
                    if videoURL != ""{
                            WebView(url: videoURL)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 500, maxHeight: .infinity, alignment: .center)
                    } else {
                        ImageLoaderView(withURL: recipeViewModel.recipe.photoUrl)
                        .frame(minWidth: 300, idealWidth: 400, maxWidth: .infinity, minHeight: 300, idealHeight: 400, maxHeight: .infinity, alignment: .center)
                    }
                    // QLOOK
                    RecipeAttributeView(recipe: recipeViewModel.recipe)
                    // INGREDIENTS
                    IngredientsList(ingredients: recipeViewModel.recipe.ingredients)
                    
                    // REVIEW
                    ReviewSectionView(reviewVM : ReviewViewModel(recipeId : recipeViewModel.recipe.id!))
                    
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

                }
            }
            }
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
                }
                .padding(.horizontal, 10)
                Divider()
            }
    }
}

struct DirectionsList: View {
    var steps: [String]
    var body: some View {
            VStack(alignment: .leading) {
                ForEach(steps.indices, id: \.self) { i in
                    HStack {
                        VStack (alignment: .leading, spacing: 5) {
                            Text("Step \(i + 1)")
                                .font(.headline)
                            Text(steps[i])
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    Divider()
                }
                .padding(.bottom, 10)
            }
    }
}
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.orange)
            .padding()
    }
}
struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipeViewModel: RecipeViewModel(recipe: recipesData[0]))    }
}
