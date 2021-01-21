//
//  ChallengeDetailView.swift
//  Cloud
//
//  Created by Nil Nguyen on 1/11/21.
//  Copyright © 2021 Balaji. All rights reserved.
//

import SwiftUI

struct ChallengeView: View {
    @ObservedObject var challengeVM = ChallengeViewModel("#dailymeals")
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink(destination:
                                EditRecipeView(editRecipeVM: challengeVM.submitRecipe())){
                    Text("Submit")
                }
                Text("All posts")
                    .bold()
                ForEach(challengeVM.submission){ recipe in
                    VStack(alignment: .leading) {
                        HStack{
                            if recipe.photoUrl != "" {
                                ImageLoaderView(withURL: recipe.photoUrl)
                            }
                            else if recipe.videoUrl != nil && recipe.videoUrl != ""{
                                VideoPlayer(urlString: recipe.videoUrl!)
                                    .frame(height: 150, alignment: .center)
                            }
                            Text(recipe.title)
                        }
                        Divider()
                    }
                }
            }
        }
    }
}


struct ChallengeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
