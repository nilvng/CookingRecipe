//
//  App+Injection.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/21/20.
//

import Foundation
import Resolver

extension Resolver : ResolverRegistering {
    public static func registerAllServices() {
        register { AuthenticationService() }.scope(application)
        register { FirebaseRecipeRepository() as RecipeRepository}.scope(application)
        register { FirebaseBookmarkRepository() as BookmarkRepository}.scope(application)
        

    }
}
