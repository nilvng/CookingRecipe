//
//  Recipe.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 11/24/20.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Recipe: Hashable, Identifiable, Codable {
    @DocumentID var id : String? = UUID().uuidString
    var title: String
    var owner: String
    
    var duration: Double
    var media: [String : String]
    var servings: Int
    var categories: [String]
    
    var ingredients: [String]
    var instructions: [String]
    
    //var isFavorite: Bool

    enum CodingKeys: String ,CodingKey {
        case title, owner, duration, media, servings, categories,ingredients, instructions = "steps"
    }
    
}

let recipesData = [
    Recipe(title: "Dalgona", owner: "Nil", duration: 12, media: ["photo":"dalgona_coffee"], servings: 1, categories : ["quick n easy"], ingredients: [
        "Instant black coffeee",
        "Sugar",
        "Hot water",
        "Condensed milk"
    ],
    instructions: [
        "blend the coffee, hot water and sugar in ratio 1:1:1",
        "whisk it until we got thick foam of coffeee",
        "Pour milk to glass with ice and the mixture on top"
    ]),
    Recipe(title:"Avocado Crostini", owner: "Khoa", duration: 20, media: ["":""], servings: 2, categories : ["quick n easy"], ingredients: [
        "1 punnet cherry Tomatoes, halved",
        "4 hard boiled eggs, halved and sliced",
        "1 carrot, cut into thin strips",
        "3 handfuls of mixed lettuce leaves, torn",
        "1 avocado, skin and seed removed and cut into cubes",
        "1 bunch of parsley, coarsley chopped",
        "2 tbsp. olive oil",
        "1 lemon, juiced",
        "Salt and pepper, to taste",
        "Loaf of your favourite bread, sliced"
    ],
    instructions: [
        "In a small jar, add the olive oil, lemon juice, salt, pepper and the stalks of the parsely. Closed the lid and shake until combined into an almost creamy texture.",
        "Toast the bread slices on a griddle or in the toaster, allow to cool slightly",
        "In a large bowl combine the rest of your ingredients",
        "Pour the parsley dressing over and toss until the avocado and eggs creams the salad together",
        "Place a generous spoonful of the salad onto each slice of toast and serve"

    ])
]

