//
//  TaskView.swift
//  Task Manager
//
//  Created by Zhuanz1密码0000 on 2024/9/9.
//

import SwiftUI
import SwiftData

struct TaskView: View {
    
    @Binding var date: Date
    
    @Query private var tasks: [Task]
    init(date: Binding<Date>) {
        self._date = date
        
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date.wrappedValue)
//        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startDate)
        guard let endOfDate = calendar.date(byAdding: .day, value: 1, to: startDate) else {
                   fatalError("Unable to calculate endOfDate")
               }
        
        let predicate = #Predicate<Task> {
                 return $0.date >= startDate && $0.date < endOfDate
             }
        
        let sortDescriptor = [
            SortDescriptor(\Task.date, order: .reverse)
        ]
        
        self._tasks = Query(filter: predicate, sort: sortDescriptor, animation: Animation.snappy)
         
    }
    
    var body: some View {
        VStack(alignment: .leading, content: {
            ForEach(tasks) { task in
                TaskItem(task: task)
                    .background(alignment: .leading) {
                        if tasks.last?.id != task.id {
                            Rectangle()
                                .frame(width: 1)
                                .offset(x: 24, y: 4)
                        }
                    }
            }
        })
        .padding(.top)
        .overlay {
            if tasks.isEmpty {
                Text("No task's added")
                    .font(.caption)
                    .frame(width: 100)
            }
//            6.14
        }
    }
}

#Preview {
    ContentView()
}
