//
//  TaskService.swift
//  ToDoApp
//
//  Created by Caner Karabulut on 17.09.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct TaskService {
    static private var pastTasks = [TaskModel]()
    static private var tasks = [TaskModel]()

    static func sendTask(text: String, completion: @escaping(Error?) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
    
        let taskId = NSUUID().uuidString
        let data = [
            "text": text,
            "date": Timestamp(date: Date()),
            "taskId": taskId
        ] as [String: Any]
        collection_tasks.document(currentUid).collection("ongoing_tasks").document(taskId).setData(data, completion: completion)
        
    }
    static func deleteTask(task: TaskModel) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let data = [
            "text": task.text,
            "taskId": task.taskId,
            "timestamp": Timestamp(date: Date())
        ] as [String : Any]
        
        collection_tasks.document(uid).collection("completed_tasks").document(task.taskId).setData(data) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            collection_tasks.document(uid).collection("ongoing_tasks").document(task.taskId).delete()
        }
    }
    
    static func fetchUser(uid: String, completion: @escaping(UserModel) -> Void) {
        collection_users.document(uid).getDocument { snapshot, error in
            guard let data = snapshot?.data() else { return }
            let user = UserModel(data: data)
            completion(user)
        }
    }
    static func fetchTasks(uid: String,completion: @escaping([TaskModel]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        collection_tasks.document(uid).collection("ongoing_tasks").order(by: "date" , descending: true).addSnapshotListener { snapshot, error in
            tasks = []
            if let documents = snapshot?.documents {
                for doc in documents {
                    let data = doc.data()
                    tasks.append(TaskModel(data: data))
                    completion(tasks)
            }
        }
    }
}
    static func fetchPastTasks(uid: String,completion: @escaping([TaskModel]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        collection_tasks.document(uid).collection("completed_tasks").order(by: "timestamp").addSnapshotListener { snapshot, error in
            pastTasks = []
                if let documents = snapshot?.documents {
                    for doc in documents {
                        let data = doc.data()
                        pastTasks.append(TaskModel(data: data))
                        completion(pastTasks)
            }
         }
      }
   }
}
