//
//  TaskView.swift
//  Task Manager
//
//  Created by Zhuanz1密码0000 on 2024/9/9.
//

import SwiftUI
import SwiftData

struct TaskView: View {
    
    let imgUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTq9ttoFS2B9Ws8S-1Yk-HJcwthupTuY4yppQ&s"
    
    @Binding var date: Date
    
    @Query private var tasks: [Task]
    init(date: Binding<Date>) {
        self._date = date
        
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date.wrappedValue)
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
        .padding(.top, 400)
        .overlay {
            if tasks.isEmpty {
                VStack{
                    AsyncImage(url: URL(string: imgUrl)) { image in image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    } placeholder: {
                        ProgressView()
                    }
                    Text("No task's added")
                        .font(.caption)
                        .frame(width: 100)
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    ContentView()
}
