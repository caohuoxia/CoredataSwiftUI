//
//  StudentListView.swift
//  CoredataSwiftUI
//
//  Created by caohx on 2022/2/18.
//

import SwiftUI

struct StudentListView: View {
    // 读取viewContext，赋值给managedObjectContext属性
    @Environment(\.managedObjectContext) var managedObjectContext
    // 读取Movie对象集，赋值给movies数组。没有要求传入任何name
    @FetchRequest(entity: Student.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Student.name, ascending: true)]) var students: FetchedResults<Student>
    
    @State var isPresented = false

    var body: some View {
      NavigationView {
        List {
          ForEach(students, id: \.name) {
            StudentRow(student: $0)
          }
          .onDelete(perform: deleteStudent)
        }
        .navigationBarTitle(Text("Students Management"))
        .navigationBarItems(trailing:
          Button(action: {
            self.addStudent(name: "bfo", age: 20, score: 100, sex: "男")
          }) {
            Image(systemName: "plus")
          }
        )
      }
    }

    // 删除一个movie，并更新coredata数据库
    func deleteStudent(at offsets: IndexSet) {
//        withAnimation {
            // 1.
            offsets.forEach { index in
              // 2.
              let student = self.students[index]

              // 3.
              self.managedObjectContext.delete(student)
            }

            // 4.
            saveContext()
//        }
    }

    func addStudent(name: String, age: Int16, score: Int16, sex: String) {
      // 1 从viewContext获取一个Movie对象
      let newStudent = Student(context: managedObjectContext)

      // 2
        newStudent.name = name
        newStudent.age = age
        newStudent.score = score
        newStudent.sex = sex

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

struct StudentListView_Previews: PreviewProvider {
    static var previews: some View {
        StudentListView()
    }
}
