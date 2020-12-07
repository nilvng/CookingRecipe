//
//  AppView.swift
//  CanCookHomePage
//
//  Created by Tran Doan Dang Khoa on 02/12/2020.
//

import SwiftUI

struct AppView: View {
  var body: some View {
    TabView {
      HomeView()
        .tabItem({
            Image(systemName: "menubar.rectangle")
          Text("Home")
        })
//        CategoriesView()
//            .tabItem({
//                Image(systemName: "face.smiling.fill")
//              Text("Categories")
//            })
//        ProfileView()
//            .tabItem ({
//                Image(systemName: "person.2.circle")
//              Text("Profile")
//            })

    }
    .edgesIgnoringSafeArea(.all)
    .accentColor(Color.primary)
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView()
      .previewDevice("iPhone 11 Pro")
      .environment(\.colorScheme, .light)
  }
}
