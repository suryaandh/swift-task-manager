//
//  OffsetKey.swift
//  Task Manager
//
//  Created by Zhuanz1密码0000 on 2024/9/9.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
   static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
