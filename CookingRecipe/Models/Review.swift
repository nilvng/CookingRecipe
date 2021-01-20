//
//  Review.swift
//  CookingRecipe
//
//  Created by Minh Anh Tran 2 on 21/12/2020.
//
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Review: Codable, Identifiable {
    @DocumentID var id : String? = UUID().uuidString
    var userid: String
    var username: String
    var email: String
    var comment: String
    var date : String

    init(id: String, userid: String, username: String, email: String, comment: String, date: String)
    {
        self.id = id
        self.userid = userid
        self.username = username
        self.email = email
        self.comment = comment
        self.date = date
    }
    
    init(vs: ReviewViewState) {
        userid = vs.userid
        username = vs.username
        email = vs.email
        comment = vs.comment
        date = Self.dateToString(Date())
    }

    static func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
        return dateFormatter.string(from: date)
    }
}
struct ReviewViewState {
     let userid: String
     let username: String
     let email: String
     let comment: String
 }
