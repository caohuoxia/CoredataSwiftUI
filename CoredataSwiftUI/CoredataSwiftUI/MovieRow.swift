//
//  MovieRow.swift
//  CoredataSwiftUI
//
//  Created by caohx on 2022/2/17.
//

import SwiftUI

struct MovieRow: View {
    let movie: Movie
    static let releaseFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    var body: some View {
        VStack(alignment: .leading) {
            // 避免了可选型的处理,coredata的entity的所有属性都是可选型的
            movie.title.map(Text.init).font(.title)
            HStack {
                movie.genre.map(Text.init).font(.caption)
                Spacer()
                movie.releaseDate.map{Text(MovieRow.releaseFormatter.string(from: $0))}.font(.caption)
            }
        }
    }
}

//struct MovieRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieRow()
//    }
//}
