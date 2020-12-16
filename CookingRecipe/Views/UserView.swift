//
//  UserView.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/11/20.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        VStack {
            Text("Favorites")
                .font(.title)
            
            Text("Created")
                .font(.title)
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
