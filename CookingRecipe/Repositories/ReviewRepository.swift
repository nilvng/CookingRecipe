//
//  ReviewManager.swift
//  CookingRecipe
//
//  Created by Minh Anh Tran 2 on 24/12/2020.
//
import Foundation
import Firebase
import FirebaseFirestore

class ReviewRepository{
    // MARK: - PROPEERTIES
    static let shared = ReviewRepository()
    
    var reviewGranted: Bool?
    var reviewData : [Review] = [Review]()
    var recipeId: String?
    var reviewId: String?
    let db = Firestore.firestore()
    
    // MARK: - BODY
    private init() {
        do
        {
            self.recipeId = ""
//            self.reviewData = try loadReviews()
            self.reviewId = ""
        }
        catch {
            print("Init error")
        }
    }
    
    // MARK: - FUMCTIONS
    func requestForReview() {
        //Code Process
        reviewGranted = true
    }

    func makeReviewPath() -> String {
        var rvwPath : String = "Recipe/\(recipeId!)/review"
        
        if rvwPath == "Recipe//review" || rvwPath ==  "" {
            rvwPath = ReviewView.dummyPath
        }
        return rvwPath
    }
    
//    func loadReviews() throws -> [Review] {
//        print("Loading reviews ....")
//
//        let reviewPath = makeReviewPath()
//
//        print("NEW reviewPath=\(reviewPath)")
//
//        var reviews = [Review]()
//
//        db.collection(reviewPath).addSnapshotListener { (querySnapshot, err) in
//            if let querySnapshot = querySnapshot {
//                reviews = querySnapshot.documents.compactMap { document -> Review? in
//                    try? document.data(as: Review.self)
//                }
//            } else {
//                print(err!.localizedDescription)
//            }
//        }
//        print("reviews count = \(reviews.count)")
//        return reviews
//    }
    
    func addReview(_ review: Review) {
        let db = Firestore.firestore()
        let reviewPath = makeReviewPath()
        
        do {
          let _ = try db.collection(reviewPath).addDocument(from: review)
        }
        catch {
          print("There was an error while trying to save a task \(error.localizedDescription).")
        }
      }
    
    func updateReview(_ review: Review) {
        if let reviewID = review.id {
            let reviewPath = makeReviewPath()
            do {
                try db.collection(reviewPath).document(reviewID).setData(from: review)
            }
            catch {
                print("There was an error while trying to save a task \(error.localizedDescription).")
            }
        }
      }
    func deleteReview(){
        let db = Firestore.firestore()
        let reviewPath = makeReviewPath()
        
        db.collection(reviewPath).document(reviewId!).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
}
