//
//  MovieList.swift
//  CoredataSwiftUI
//
//  Created by caohx on 2022/2/17.
//

import SwiftUI

struct MovieList: View {
    // 读取viewContext，赋值给managedObjectContext属性
    @Environment(\.managedObjectContext) var managedObjectContext
    // 读取Movie对象集，赋值给movies数组。没有要求传入任何name
    @FetchRequest(entity: Movie.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Movie.title, ascending: true)]
//        ,predicate: NSPredicate(format: "title contains 'Action'")
    ) var movies: FetchedResults<Movie>
    
    @State var isPresented = false

    var body: some View {
      NavigationView {
        List {
          ForEach(movies, id: \.title) {
            MovieRow(movie: $0)
          }
          .onDelete(perform: deleteMovie)
        }
        .sheet(isPresented: $isPresented) {
          AddMovieView { title, genre, release in
            self.addMovie(title: title, genre: genre, releaseDate: release)
            self.isPresented = false
          }
        }
        .navigationBarTitle(Text("Fave Flicks"))
        .navigationBarItems(trailing:
          Button(action: { self.isPresented.toggle() }) {
            Image(systemName: "plus")
          }
        )
      }
    }

    // 删除一个movie，并更新coredata数据库
    func deleteMovie(at offsets: IndexSet) {
      // 1.
      offsets.forEach { index in
        // 2.
        let movie = self.movies[index]

        // 3.
        self.managedObjectContext.delete(movie)
      }

      // 4.
      saveContext()
    }

    // 添加一个movie，并更新保存数据库
    func addMovie(title: String, genre: String, releaseDate: Date) {
      // 1 从viewContext获取一个Movie对象
      let newMovie = Movie(context: managedObjectContext)

      // 2
      newMovie.title = title
      newMovie.genre = genre
      newMovie.releaseDate = releaseDate

      // 3
      saveContext()
    }


    func saveContext() {
      do {
        try managedObjectContext.save()
      } catch {
        print("Error saving managed object context: \(error)")
      }
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList()
    }
}
