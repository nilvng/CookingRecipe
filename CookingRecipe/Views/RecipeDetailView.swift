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
    
    var body: some View {
            //List{
            ScrollView(.vertical, showsIndicators: false) {
                VStack (alignment: .leading) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.backward")
                    }.padding(.bottom, 5).padding(.trailing, 5)
                    HStack {
                        Text(recipeViewModel.recipe.title)
                            .font(.title)
                            .bold()
                        Image(systemName: "heart")
                    }
                    // OWNER
                    Text("by \(recipeViewModel.recipe.owner)")
                        .font(.body)
                        .padding(.leading, 7)
                    // meal's image
                    if let videoURL = recipeViewModel.recipe.media["video"] {
                    WebView(url: videoURL)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 500, maxHeight: .infinity, alignment: .center)
                    } else {
                        FirebaseImage(id: recipeViewModel.recipe.media["photo"]!)


                    }
                    // QLOOK
                    RecipeQLook(recipe: recipeViewModel.recipe)
                    // INGREDIENTS
                    Text("Ingredients")
                        .bold()
                        .font(.title2)
                        .padding(.horizontal, 7)
                        .padding(.bottom, 5)
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
                        Text("Start cooking")
                            .font(.subheadline)
                        Image(systemName: "play")
                            
                    }
                    .padding(.vertical,7)
                    .padding(.horizontal, 120)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(7)
                    .frame(maxWidth: .infinity)
                    .sheet(isPresented: $startCooking){
                        DirectionsCarouselView(steps: recipeViewModel.recipe.instructions)
                        
                    }
                    // list
                    DirectionsList(steps: recipeViewModel.recipe.instructions)
                    
                    // REVIEW
                }
//            }
//            .navigationTitle("")
//            .navigationBarHidden(true)
//            .navigationBarTitle(Text(recipeViewModel.recipe.title))
//            .navigationBarItems(trailing:
//                                    Button(action:{
                                        //recipeViewModel.recipe.isFavorite.toggle()
//                                    }){
//                                        if recipeViewModel.recipe.isFavorite{
//                                            Image(systemName: "heart.fill")
//                                                .imageScale(.large)
//                                        } else{
//                                            Image(systemName: "heart")
                                        //}
//                                    }
//            )
         }
    }
}

//struct RecipeDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDetailView()    }
//}

struct RecipeQLook: View {
    var recipe: Recipe
    var body: some View {
        HStack (alignment: .center,
                spacing: 25){
            HStack {
                Image(systemName: "person")
                Text("\(recipe.servings) Serve")
            }
            Spacer()
            
            HStack (alignment: .center, spacing: 2) {
                Image(systemName: "person")
                Text("\(recipe.ingredients.count) Ingredients")
            }

            Spacer()
            HStack {
                Image(systemName: "clock")
                Text("20" + "m")
            }
        }
        .padding()
        .font(.callout)
        .foregroundColor(Color.gray)
    }
}

struct RecipeQuickView: View {
  // MARK: - PROPERTIES
  
  var recipe: Recipe
  
  var body: some View {
    HStack(alignment: .center, spacing: 12) {
      HStack(alignment: .center, spacing: 2) {
        Image(systemName: "person.2")
        Text("Serves: \(recipe.servings)")
      }
      HStack(alignment: .center, spacing: 2) {
        Image(systemName: "clock")
        Text("Prep: \(recipe.duration)")
      }
      HStack(alignment: .center, spacing: 2) {
        Image(systemName: "flame")
        Text("Cooking: \(recipe.ingredients.count)")
      }
    }
    .font(.footnote)
    .foregroundColor(Color.gray)
  }
}

struct IngredientsList: View {
    var ingredients: [String]
    var body: some View {
            ForEach(ingredients, id: \.self) { item in
                HStack {
                    Text(item)
                    Spacer()
                    Text("1 pack")
                        .bold()
                }
                .padding(.horizontal, 10)
                Divider()
            }
    }
}
