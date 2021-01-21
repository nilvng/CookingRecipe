//
//  ReviewViewModel.swift
//  CookingRecipe
//
//  Created by Ngan Nguyen Bao on 1/20/21.
//

import Foundation
import Firebase
import Resolver

class ReviewViewModel: ObservableObject {
    
    @Published var reviews = [Review]()
    @Published var yourReview : Review?
    
    private var db = Firestore.firestore()
    var reviewPath : String
    @Injected var authService : AuthenticationService
    
    init(recipeId : String) {
        self.reviewPath = "Recipe/\(recipeId)/reviews"
        fetchReviews()
    }
    
    func fetchReviews() {
        db.collection(reviewPath)
            .getDocuments() { (querySnapshot, err) in
                if let queryss = querySnapshot {
                    self.reviews = queryss.documents.compactMap { document -> Review? in
                        try? document.data( as: Review.self )
                    }
                    self.getYourReview()
                }
            }
    }
    
    func getYourReview(){
        guard self.reviews.count > 1 else {
            return
        }
        var i = -1
        self.reviews.enumerated().forEach { (index, element) in
            if element.userid == self.authService.user?.uid {
                self.yourReview = element
                i = index
            }
        }
        if i > -1 {
            self.reviews.remove(at: i)
        } else {
            self.yourReview = nil
        }
    }
    
    func addReview(_ review : Review){
        guard let userid = authService.user?.uid else {
            return
        }
        var review = review
        review.userid = userid
        review.username = authService.user?.displayName ?? "null"
        do {
          let _ = try db.collection(reviewPath).addDocument(from: review)
        }
        catch {
          print("There was an error while trying to save a task \(error.localizedDescription).")
        }
        
        fetchReviews()
    }
    
    func deleteReview(_ review : Review){
        guard review.id != nil else {
            return
        }
        db.collection(reviewPath).document(review.id!).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        fetchReviews()
    }
    
    func updateReview(_ review1: Review) {
        guard let userid = authService.user?.uid else {
            return
        }
        var review = review1
        review.userid = userid
        review.username = authService.user?.displayName ?? "null"
        if let reviewID = review.id {
            do {
                try db.collection(reviewPath).document(reviewID).setData(from: review)
            }
            catch {
                print("There was an error while trying to save a task \(error.localizedDescription).")
            }
        }
        fetchReviews()
    }
}
    
