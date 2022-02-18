//
//  HomeView.swift
//  CoredataSwiftUI
//
//  Created by caohx on 2022/2/18.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            MovieList().tabItem { Label("Movie", systemImage: "film") }
            StudentListView().tabItem { Label("Student", systemImage: "person") }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
