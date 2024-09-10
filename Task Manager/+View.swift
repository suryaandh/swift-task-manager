//
//  +View.swift
//  Task Manager
//
//  Created by Zhuanz1密码0000 on 2024/9/8.
//

import SwiftUI

extension View{
    
    @ViewBuilder
    func hSpacing(_ alignment: Alignment)-> some View{
        self.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: alignment)
    }
    
    func vSpacing(_ alignment: Alignment)-> some View{
        self.frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: alignment)
    }
    
    func isSameDate(_ date1: Date, _ date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
}
