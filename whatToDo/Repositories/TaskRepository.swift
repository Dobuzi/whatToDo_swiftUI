//
//  TaskRepository.swift
//  toDoList
//
//  Created by 김종원 on 2020/09/28.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskRepository: ObservableObject {
    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        if let userId = Auth.auth().currentUser?.uid {
            db.collection("tasks")
                .whereField("userId", isEqualTo: userId)
                .order(by: "createdTime")
                .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.tasks = querySnapshot.documents.compactMap { document in
                        do {
                            return try document.data(as: Task.self)
                        } catch {
                            print(error)
                        }
                        return nil
                    }
                }
            }
        }
    }
    
    func addTask(_ task: Task) {
        do {
            let _ = try db.collection("tasks").addDocument(from: task)
        } catch {
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
    }
    
    func updateTask(_ task: Task) {
        if let taskId = task.id {
            do {
                try db.collection("tasks").document(taskId).setData(from: task)
            } catch {
                fatalError("Unable to encode task: \(error.localizedDescription)")
            }
        }
    }
}
