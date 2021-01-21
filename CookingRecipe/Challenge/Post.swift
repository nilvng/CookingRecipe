//
//  Post.swift
//  CookingRecipe
//
//  Created by Tran Doan Dang Khoa on 21/01/2021.
//

import Foundation

struct Post : Identifiable {
    
    var id : Int
    var name : String
    var url : String
    var seen : Bool
    var proPic : String
    var loading : Bool
}
