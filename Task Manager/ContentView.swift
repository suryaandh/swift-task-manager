//
//  ContentView.swift
//  Task Manager
//
//  Created by Zhuanz1密码0000 on 2024/9/2.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentDate: Date = .init()
    
    //Week Slider
    @State var weekSlider : [[Date.WeekDay]] = []
    @State var currentWeekIndex: Int = 0
    @Namespace private var animation
    @State private var createWeek: Bool = false
    @State private var createNewTask: Bool = false
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0, content: {
            VStack(alignment: .leading, content: {
                Text("Calendar")
                    .font(.system(size: 36, weight: .semibold))
                
                //WeekSlider
                TabView(selection: $currentWeekIndex,
                        content:  {
                    ForEach(weekSlider.indices, id: \.self) {
                        index in let week = weekSlider[index]
                    
                        weekView(week).tag(index)
                    }
                })
            #if os(iOS)
                .tabViewStyle(.page(indexDisplayMode: .never))
            #endif
            .frame(height: 90)
                
            })
            .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background {
                Rectangle().fill(.gray.opacity(0.1))
                    .clipShape(.rect(bottomLeadingRadius: 30, bottomTrailingRadius: 30))
                    .ignoresSafeArea()
            }
            .onChange(of: currentWeekIndex, initial: false) { oldValue, newValue in if newValue == 0 || newValue == (weekSlider.count - 1) {
                createWeek = true
                }
            }
            
            ScrollView(.vertical){
                VStack{
                    TaskView(date: $currentDate)
                }
                .hSpacing(.center)
                .vSpacing(.center)
            }
        })
        .vSpacing(.top)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .onAppear() {
            if weekSlider.isEmpty {
                let currentWeek = Date().fetchWeek()
                
                if let firstDate = currentWeek.first?.date {
                    weekSlider.append(firstDate.createPreviousWeek())
                }
              
                if let lastDate = currentWeek.last?.date {
                    weekSlider.append(lastDate.createNextWeek())
                }
            }
        }
        .overlay(alignment: .bottomTrailing) {
            Button(action: {
                createNewTask.toggle()
            }, label: {
                Image(systemName: "plus")
                    .imageScale(.large)
                    .padding(26)
                    .background(.black)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .padding([.horizontal])
                    .foregroundColor(.white)
            })
            #if os(iOS)
            .fullScreenCover(isPresented: $createNewTask, content: {
                NewTask()
            })
            #endif
            .frame(height: 90)
        }
    }
    
    @ViewBuilder
    func weekView(_ week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0){
            ForEach(week) { day in VStack {Text(day.date.format("E"))
                    .font(.callout)
                    .fontWeight(.medium)
                    .textScale(.secondary)
                    .foregroundStyle(.gray)
                
                Text(day.date.format("dd"))
                    .font(.system(size: 20))
                    .frame(width: 50, height: 55)
                    .foregroundStyle(isSameDate(day.date, currentDate) ? .white : .black)
                    .background(content: {
                        if isSameDate(day.date, currentDate){
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.black)
                                .offset(y: 3)
                                .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
                        }
                        
                        if day.date.isToday {
                            Circle()
                                .fill(.white)
                                .frame(width: 5, height: 5)
                                .vSpacing(.bottom)
                        }
                    })
                }
            .hSpacing(.center)
            .onTapGesture {
                withAnimation(.snappy){
                    currentDate = day.date
                    }
                }
            }
        }
        .background {
            GeometryReader {
                let minX = $0.frame(in: .global).minX
                
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self, perform: { value in
                        if value.rounded() == 15 && createWeek {
                            paginateWeek()
                            createWeek = false
                        }
                    })
            }
        }
    }
    
    func paginateWeek() {
        if weekSlider.indices.contains(currentWeekIndex) {
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0 {
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
            
            if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == (weekSlider.count - 1) {
                weekSlider.append(lastDate.createNextWeek())
                weekSlider.removeFirst()
                currentWeekIndex = weekSlider.count - 2
            }
        }
    }
}

#Preview {
    ContentView()
}
