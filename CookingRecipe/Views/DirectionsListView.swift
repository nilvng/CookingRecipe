//
//  IngredientList.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 11/23/20.
//

import SwiftUI

struct DirectionsList: View {
    var steps: [String]
    var body: some View {
            VStack(alignment: .leading) {
                ForEach(steps.indices, id: \.self) { i in
                    HStack {
                        Image("dalgona_coffee")
                            .resizable()
                            .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        VStack (alignment: .leading, spacing: 5) {
                            Text("Step \(i + 1)")
                                .font(.headline)
                            Text(steps[i])
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    Divider()
                }
                .padding(.bottom, 10)
            }
    }
}

struct DirectionsList_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsList(steps: recipesData[0].instructions)
    }
}
