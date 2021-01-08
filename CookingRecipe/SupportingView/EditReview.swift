//
//  EditReview.swift
//  CookingRecipe
//
//  Created by Minh Anh Tran 2 on 05/01/2021.
//

import SwiftUI
import Resolver

struct EditReview: View {
    @State var comment: String = ""
    @State var onEditing: Bool = false
    @State var success: Bool = false
    @Injected var authService : AuthenticationService
    
    var review: Review

    init(review: Review) {
        self.review = review
        self.comment = self.review.comment
        // print("Init: comment=\(comment)")
    }
    
    var body: some View {
        VStack {
            // Text("Edit your review:")
        if onEditing {
            TextField("Enter update review", text: $comment)
                .textFieldStyle(MyTextFieldStyle()).border(Color.blue)
            HStack(alignment: VerticalAlignment.center, spacing: 5) {
                Spacer()
                Button(action: updateReview, label: {
                    Image(systemName: "paperplane.circle.fill")
                })
                .frame(alignment: .trailing)
            }
        } else {
            Text(success ? "Updating review success" : "Cancel editing")
            Text("Please click edit review icon")
        }
        }
        .onAppear() {
            onEditing.toggle()
            comment = self.review.comment
        }
        
    }
    
    func updateReview() {
        let updateReview =
            Review(id: review.id!, userid: authService.user!.uid, username: authService.user?.displayName ?? "", email: authService.user?.email ?? "", comment: comment, date: Review.dateToString(Date()))
        ReviewRepository.shared.updateReview(updateReview)
        success = true
        onEditing = false
    }
}

