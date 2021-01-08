
//
//  CreateReview.swift
//  CookingRecipe
//
//  Created by Minh Anh Tran 2 on 22/12/20.
//

import SwiftUI
import Resolver
struct CreateReview: View {
    @State var comment: String = ""
    @State var onAdding: Bool = false
    @State var success: Bool = false
    @Injected var authService : AuthenticationService
    var exist: Bool
    
    init(exist: Bool) {
        self.exist = exist
    }
    
    var body: some View {
        if (!exist) {
            VStack {
                Text("Create new review")
                if onAdding {
                    TextField("Enter review", text: $comment)
                        .textFieldStyle(MyTextFieldStyle()).border(Color.blue)
                    HStack(alignment: VerticalAlignment.center, spacing: 5) {
                        Spacer()
                        Button(action: addReview, label: {
                            Image(systemName: "paperplane.circle.fill")
                        })
                        .frame(alignment: .trailing)
                    }
                } else {
                    Text(success ? "Adding review success" : "Cancel adding")
                    Text("Please click crossmark icon")
                }
            }
            .onAppear() {
                onAdding.toggle()
            }
        } else {
            Text("Your review has existed, plase edit your own")
        }
    }
    
    func addReview() {
        let newReview = Review(vs: ReviewViewState(userid: authService.user!.uid, username: authService.user?.displayName ?? "", email: authService.user?.email ?? "", comment: comment))
        ReviewRepository.shared.addReview(newReview)
        success = true
        onAdding = false
    }
}

struct CreateReview_Previews: PreviewProvider {
    static var previews: some View {
        CreateReview(exist: false)
    }
}

struct MyTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(30)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.red, lineWidth: 3)
            ).padding()
    }
}
