//
//  CategoryViewModel.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/8/20.


//import Foundation
//import Combine
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//
//class ReviewViewModel: ObservableObject, Identifiable {
//
//    var db = Firestore.firestore()
//    var review : Review
//    init(review : Review){
//        self.review = review
//    }
//
//}
//
//  ReviewViewModel.swift
//  CookingRecipe
//
//  Created by Minh Anh Tran 2 22/12/2020.
//

import Foundation
import Combine
import Disk
import SwiftUI
import Firebase


struct ReviewViewState {
    let userid: String
    let username: String
    let email: String
    let comment: String
    // let date: String
}

struct ReviewViewModel : Codable {
    
    let review: Review
    
    var reviewId: String {
        review.id ?? ""
    }
    
    var userid: String {
        review.userid
    }
    
    var username: String {
        review.username
    }
    
    var email: String {
        review.email
    }
    
    var comment: String {
        review.comment
    }
    
    var date: String {
        review.date
    }
}
