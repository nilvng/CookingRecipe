//
//  ReviewView.swift
//  CookingRecipe
//
//  Created by Minh Anh Tran 2 on 18/12/20.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ReviewView: View, Equatable {
    // let recipe : RecipeViewModel
    // let recipeId: String
    
    @AppStorage("reviewPath") public static var reviewPath : String = ""
    public static let dummyPath = "Recipe/VqJyajgojRKVjENBkusa/review"
    
    
    
    var body: some View {
        //Text(recipe.recipe.id!)
        Group {
            Text(ReviewRepository.shared.recipeId!)
            ReviewHome()
        }
        .onAppear(perform: myFunc)
    }
    
    func myFunc() {
        Self.reviewPath = ReviewRepository.shared.recipeId! != "" ? "Recipe/\(ReviewRepository.shared.recipeId!)/review" : Self.dummyPath
        print("Init myFunc: \(Self.reviewPath)")
        
    }
}

struct ReviewHome: View {
    @State var x : CGFloat = 0
    @State var count : CGFloat = 0
    @State var screen = UIScreen.main.bounds.width - 30
    @State var op : CGFloat = 0
//     @State var data : [Recipe] = recipesData
    
    @StateObject var reviewData = getReviews()
    // @StateObject var reviewData = ReviewManager.shared.reviewData
    

    var body: some View {
        Text("")
            .onAppear(perform: reviewData.loadData)
        
        VStack {
            
            if self.reviewData.data.isEmpty{
                if self.reviewData.noData {
                    Spacer()
                    Text("No Review !!!")
                    Spacer()
                }
                else{
                    Spacer()
                    //Data is Loading ....
                    Indicator()
                    Spacer()
                }
            } else {
                VStack{
                    Text("count=\(reviewData.data.count)")
//                    Spacer()
                    HStack(spacing: 15){
//                    ScrollView(.horizontal, showsIndicators: false){
//                    HStack{
                        ForEach(reviewData.data){i in
                            CardView(data: i)
                                .offset(x: self.x)
                                .highPriorityGesture(
                                    DragGesture()
                                        .onChanged({ (value) in

                                            if value.translation.width > 0{
                                                self.x = value.location.x
                                            }
                                            else{
                                                self.x = value.location.x - self.screen
                                            }
                                        })
                                        .onEnded({ (value) in
                                            if value.translation.width > 0{
                                                if value.translation.width > ((self.screen - 80) / 2) && Int(self.count) != 0{
                                                    self.count -= 1
                                                    self.x = -((self.screen + 15) * self.count)
                                                } else{
                                                    self.x = -((self.screen + 15) * self.count)
                                                }
                                            } else{
                                                if -value.translation.width > ((self.screen - 80) / 2) && Int(self.count) !=  (self.reviewData.data.count - 1){
                                                    self.count += 1
                                                    self.x = -((self.screen + 15) * self.count)
                                                } else{
                                                    self.x = -((self.screen + 15) * self.count)
                                                }
                                            }
                                        })
                                )
                        } //: FOREACH
                    }
                    .frame(width: UIScreen.main.bounds.width - 25)
                    .offset(x: self.op)
                    Spacer()
                } //: VSTACK
                .frame(height:300)
                .background(Color.black.opacity(0.07).edgesIgnoringSafeArea(.bottom))
                .animation(.spring())
                .onAppear {
                    let delta = self.reviewData.data.count % 2 == 0 ? (self.screen + 15) / 2 : 0
                    self.op = (self.screen + 15) * CGFloat(self.reviewData.data.count / 2) - delta
                }
            } //: ELSE
        }
    }
        }


class getReviews: ObservableObject {
    @Published var data = [Review]()
    @Published var noData = false
    
    func loadData() {
        data.removeAll()
        noData = false
        
        print("Before: on reviewPath=\(ReviewView.reviewPath)")
        
        let db = Firestore.firestore()
        // ReviewView.reviewPath =  "Recipe/\(recipe.recipe.id!)/review"
        if ReviewView.reviewPath == "Recipe//review" || ReviewView.reviewPath ==  "" {
            ReviewView.reviewPath = ReviewView.dummyPath
        }
        print("loadData on reviewPath=\(ReviewView.reviewPath)")
        
        db.collection(ReviewView.reviewPath).order(by: "date", descending: false).addSnapshotListener { (snap, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                self.noData = true
                return
            }
            if (snap?.documentChanges.isEmpty)!{
                self.noData = true
                return
            }
            for i in snap!.documentChanges{
                if i.type == .added{
                    let id = i.document.documentID
                    let userid = i.document.get("userid") as! String
                    let username = i.document.get("username") as! String
                    let email = i.document.get("email") as! String
                    let comment = i.document.get("comment") as! String
                    let date = i.document.get("date") as! String
                    self.data.append(Review(id: id, userid: userid, username: username, email: email, comment: comment, date: date))
                }
                
                if i.type == .modified{
                    // when data is changed...
                    let id = i.document.documentID
                    let userid = i.document.get("userid") as! String
                    let username = i.document.get("username") as! String
                    let email = i.document.get("email") as! String
                    let comment = i.document.get("comment") as! String
                    let date = i.document.get("date") as! String
                    for i in 0..<self.data.count{
                        if self.data[i].id == id{
                            self.data[i].userid = userid
                            self.data[i].username = username
                            self.data[i].email = email
                            self.data[i].comment = comment
                            self.data[i].date = date
                        }
                    }
                }
                
                if i.type == .removed{
                    // when data is removed...
                    let id = i.document.documentID
                    for i in 0..<self.data.count{
                        if self.data[i].id == id {
                            self.data.remove(at: i)
                            if self.data.isEmpty{
                                self.noData = true
                            }
                            return
                        }
                    }
                }
            }
        }
    }
}


struct CardView : View {
    
    var data : Review
    
    var body : some View{
        VStack(alignment: .leading, spacing: 0){
            Text(data.username)
                .font(.title)
            Text(data.email)
                .font(.title3)
                .fontWeight(.medium)
            Spacer()
            Text(data.comment)
                .fontWeight(.bold)
                .multilineTextAlignment(TextAlignment.leading)
                .frame(width: UIScreen.main.bounds.width - 50,alignment: .leading)
                .padding(.top)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 30, height: 250)
        .background(Color.white)
        .cornerRadius(25)
    }
}

struct Indicator : UIViewRepresentable {
    // MARK: METHODS
    func makeUIView(context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .medium)
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
    }
}
