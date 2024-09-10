//
//  NewTask.swift
//  Task Manager
//
//  Created by Zhuanz1密码0000 on 2024/9/9.
//

import SwiftUI

struct NewTask: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var taskTitle: String = ""
    @State private var taskDate: Date = .init()
    @State private var taskColor: Color = .yellow
    
    var body: some View {
        VStack(alignment: .leading, content: {
            VStack(alignment: .leading, content: {
              Label("Add New Task ", systemImage: "arrow.left")
                    .onTapGesture {
                        dismiss()
                    }
            })
            .hSpacing(.leading)
            .padding(30)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background{
                Rectangle().fill(.gray.opacity(0.1))
                    .clipShape(.rect(bottomLeadingRadius: 30, bottomTrailingRadius: 30))
                    .ignoresSafeArea()
            }
            
            VStack(alignment: .leading, spacing: 30, content: {
                VStack(spacing: 20, content: {
                   TextField("Your Task Title", text:  $taskTitle)
                    Divider()
                })
                VStack(alignment: .leading, spacing: 20, content: {
                    Text("Timeline")
                        .font(.title3)
                    
                    DatePicker("", selection: $taskDate)
                        .datePickerStyle(.compact)
                    
                })
                
                VStack(alignment: .leading, spacing: 20, content: {
                  Text("Task Color")
                        .font(.title3)
                    
                    let colors: [Color] = [.yellow, .gray, .blue, .indigo, .green, .red]
                    
                    HStack(spacing: 10, content: {
                        ForEach(colors, id: \.self) { color in
                            Circle()
                                .fill(color.opacity(0.4))
                                .hSpacing(.center)
                        }
                    })
                })
            })
            .padding()
            .vSpacing(.top)
            
            Button{
                
            } label: {
                Text("Create Task")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .frame(height: 60)
                    .foregroundColor(.white)
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 20))
                    .padding(.horizontal, 30)
            }
        })
        .vSpacing(.top)
    }
    
}

#Preview {
    NewTask()
}
