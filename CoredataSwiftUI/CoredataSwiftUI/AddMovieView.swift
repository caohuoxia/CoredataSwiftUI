//
//  AddMovieView.swift
//  CoredataSwiftUI
//
//  Created by caohx on 2022/2/17.
//

import SwiftUI

struct AddMovieView: View {
    static let DefaultMovieTitle = "A defalut movie"
    static let DefaultMovieGenre = "default genre"
    
    @State var title = ""
    @State var genre = ""
    @State var releaseDate = Date()
    let onComplete: (String, String, Date) -> Void

    var body: some View {
      NavigationView {
        Form {
          Section(header: Text("Title")) {
            TextField("Title", text: $title)
          }
          Section(header: Text("Genre")) {
            TextField("Genre", text: $genre)
          }
          Section {
            DatePicker(
              selection: $releaseDate,
              displayedComponents: .date) {
                Text("Release Date").foregroundColor(Color(.gray))
            }
          }
          Section {
            Button(action: addMoveAction) {
              Text("Add Movie")
            }
          }
        }
        .navigationBarTitle(Text("Add Movie"), displayMode: .inline)
      }
    }

    private func addMoveAction() {
      onComplete(
        title.isEmpty ? AddMovieView.DefaultMovieTitle : title,
        genre.isEmpty ? AddMovieView.DefaultMovieGenre : genre,
        releaseDate)
    }
}
