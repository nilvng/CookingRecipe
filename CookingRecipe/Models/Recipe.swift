//
//  Recipe.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 11/24/20.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Recipe: Codable, Identifiable {
    @DocumentID var id : String? = UUID().uuidString
    var title: String = ""
    var owner: String = ""
    var ownerId : String = ""
    
    var duration: Double = 0.0
    var photoUrl : String = ""
    var videoUrl : String?
    var youtubeUrl : String = ""
    
    var servings: Int = 0
    
    var challenge : String = ""
    var categories = [String]()
    
    var ingredients = [String]()
    var instructions = [String]()
    
    enum CodingKeys: String ,CodingKey {
        case id, title, owner, ownerId, duration,photoUrl,videoUrl, youtubeUrl, servings, categories,ingredients, instructions = "steps"
    }
    
}

let recipesData = [
    Recipe(title: "Dalgona", owner: "Nil", ownerId: "", duration: 12, photoUrl : "",youtubeUrl: "https://youtube.com/embed/fYX1BcgWMqw", servings: 1, categories : ["quick n easy"], ingredients: [
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
    Recipe(title:"Avocado Crostini", owner: "Khoa", ownerId: "", duration: 20,photoUrl : "",youtubeUrl: "", servings: 2, categories : ["quick n easy"], ingredients: [
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

