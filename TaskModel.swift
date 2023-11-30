//
//  TaskModel.swift
//  ToDoApp
//
//  Created by Caner Karabulut on 21.09.2023.
//

import FirebaseFirestore

struct TaskModel {
    let taskId: String
    let text: String
    let timestamp: Timestamp

    init(data: [String: Any]) {
        self.taskId = data["taskId"] as? String ?? ""
        self.text = data["text"] as? String ?? ""
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}
