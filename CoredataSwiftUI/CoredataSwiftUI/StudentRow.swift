//
//  StudentRow.swift
//  CoredataSwiftUI
//
//  Created by caohx on 2022/2/18.
//

import SwiftUI

struct StudentRow: View {
    let student: Student
    
    var body: some View {
        VStack(alignment: .leading) {
            // 避免了可选型的处理,coredata的entity的所有属性都是可选型的
            student.name.map(Text.init).font(.title)
            HStack {
                Text("age: \(student.age)").font(.caption)
                Spacer()
                Text("score: \(student.score)").font(.caption)
            }
        }
    }
}
