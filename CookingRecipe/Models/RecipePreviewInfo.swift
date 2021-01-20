//
//  RecipePreviewInfo.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/17/20.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct RecipePreviewInfo : Codable, Identifiable, Equatable {
    @DocumentID var id : String?
    var title : String
    var image : String?
    @ServerTimestamp var createdTime : Timestamp?
    
    static func == (lhs: RecipePreviewInfo, rhs: RecipePreviewInfo) -> Bool{
        return
            lhs.id == rhs.id 
    }
}
