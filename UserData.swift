//
//  UserData.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 11/28/20.
//

import SwiftUI
import Combine

class UserData: ObservableObject {
    @Published var recipes = recipeData
}
