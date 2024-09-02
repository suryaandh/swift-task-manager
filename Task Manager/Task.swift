//
//  Task.swift
//  Task Manager
//
//  Created by Zhuanz1密码0000 on 2024/9/2.
//

import SwiftUI

struct Task: Identifiable{
    var id: UUID = .init()
    var title: String
    var caption: String
    var date: Date = .init()
    var isCompleted = false
    var tint: Color
}


// Sample Task
var sampleTask: [Task] = [
    .init(title: "Standup", caption: "Every day meeting ", date: Date.now, tint: .yellow),
    .init(title: "Kickoff", caption: "Travel App ", date: Date.now, tint: .gray),
    .init(title: "Ui Design", caption: "Fintech App ", date: Date.now, tint: .green),
    .init(title: "Logo Design", caption: "Fintech App ", date: Date.now, tint: .purple),
]


//Date Extension
