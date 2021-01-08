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
            Image(systemName: "house")
          Text("Browse")
        })
        CategoryView()
            .tabItem({
                Image(systemName: "globe")
              Text("Categories")
            })
        UserView()
            .tabItem ({
                Image(systemName: "person")
              Text("Library")
            })
        AuthView()
            .tabItem ({
                Image(systemName: "person")
              Text("Library")
            })

    }
    .edgesIgnoringSafeArea(.all)
    .accentColor(Color.primary)
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView()
  }
}
