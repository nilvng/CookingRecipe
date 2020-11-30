//
//  RecipeDetail.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 11/23/20.
//

import SwiftUI

struct RecipeDetail: View {
    @State var startCooking = false
    var recipe: Recipe
    var body: some View {
        NavigationView {
            //List{
            ScrollView(.vertical, showsIndicators: false) {
                VStack (alignment: .leading) {
                    // OWNER
                    Text("by \(recipe.owner)")
                        .font(.body)
                        .padding(.leading, 7)
                    // meal's image
                    Image("dalgona_coffee")
                        .resizable()
                        .frame(height: 300)
                    // meal's name
                    // Text(recipe.name)
                    //    .font(.title)

                    // QLOOK
                    RecipeQLook(recipe: self.recipe)
                    // INGREDIENTS
                    Text("Ingredients")
                        .bold()                      .font(.title2)
                        .padding(.horizontal, 7)
                        .padding(.bottom, 5)
                    IngredientsList(ingredients: recipe.ingredients)
                    // DIRECTION
                    Text("Directions")
                        .bold()                   .font(.title2)
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
                        DirectionsCarousel(steps: recipe.directions)
                            
                    }
                    // list
                    DirectionsList(steps: recipe.directions)
                    
                    // REVIEW
                    Spacer()
                }
            }
            .navigationBarTitle(Text(recipe.name))
            .navigationBarItems(trailing:
                                    Button(action:{
                                    //recipe.isFavorite.toggle()
                                    }){
                                        if recipe.isFavorite{
                                            Image(systemName: "heart.fill")
                                                .imageScale(.large)
                                        } else{
                                            Image(systemName: "heart")
                                        }
                                    }
            )
         }
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: recipeData[0])
    }
}

struct RecipeQLook: View {
    var recipe: Recipe
    var body: some View {
        HStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                spacing: 25){
            HStack {
                Image(systemName: "person.2")
                Text("\(recipe.ingredients.count) Ingredients")
            }
            Divider()
            HStack {
                Image(systemName: "person.2")
                Text("1" + " Serve")
            }
            Divider()
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
