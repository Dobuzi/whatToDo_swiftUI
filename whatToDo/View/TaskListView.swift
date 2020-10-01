//
//  TaskListView.swift
//  toDoList
//
//  Created by 김종원 on 2020/09/28.
//

import SwiftUI
import FirebaseAuth

struct TaskListView: View {
    @ObservedObject var taskListViewModel = TaskListViewModel()
    
    @State var presentAddNewItem = false
    @State var showSignInForm = true
    @State var userId = Auth.auth().currentUser?.uid ?? ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List{
                    ForEach(taskListViewModel.taskCellViewModels) { taskCellViewModel in
                        TaskCell(taskCellViewModel: taskCellViewModel)
                    }
                    if presentAddNewItem {
                        TaskCell(taskCellViewModel: TaskCellViewModel(task: Task(
                                                                        title: "",
                                                                        completed: false,
                                                                        userId: userId))
                        ) { task in
                            if task.userId != "" {
                                self.taskListViewModel.addTask(task: task)
                            }
                        }
                    }
                }
                Button(action: { self.presentAddNewItem.toggle() }) {
                    HStack {
                        Image(systemName: (self.presentAddNewItem ? "xmark.circle.fill" : "plus.circle.fill"))
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor((self.presentAddNewItem ? .red : .blue))
                        Text((self.presentAddNewItem ? "Stop adding tasks" : "Add New Task"))
                            .foregroundColor((self.presentAddNewItem ? .red : .blue))
                    }
                }
                .padding()
            }
            .sheet(isPresented: $showSignInForm, content: {
                SignInView()
            })
            .navigationBarItems(trailing: Button(action: {self.showSignInForm.toggle()}, label: {
                Image(systemName: "person.crop.circle")
                    .imageScale(.large)
            }))
            .navigationTitle("Tasks")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}

struct TaskCell: View {
    @ObservedObject var taskCellViewModel: TaskCellViewModel
    
    var onCommit: (Task) -> (Void) = { _ in }
    var body: some View {
        HStack {
            Image(systemName: taskCellViewModel.completionStateIconName)
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture(count: 1, perform: {
                    self.taskCellViewModel.task.completed.toggle()
                })
            TextField("Enter the task title", text: $taskCellViewModel.task.title, onCommit: {
                self.onCommit(self.taskCellViewModel.task)
            })
        }
    }
}
