//
//  TaskItemModel.swift
//  PlanPerfect
//
//  Created by Danesh Zhao-Graham on 2023-03-25.
//

import SwiftUI

extension TaskItem
{
    func isCompleted() -> Bool{
        return completeDate != nil
    }
    
    func isOverdue() -> Bool{
        if let due = dueDate {
                let today = Calendar.current.startOfDay(for: Date())
                let isPastDueDate = !isCompleted() && (scheduleDate || scheduleTime) && due < today
                return isPastDueDate && due != today
            }
            return false
    }
    
    func overDueColor(color: Color) -> Color{
        return isOverdue() ? Color(red: 1, green: 0.27, blue: 0.23) : color
    }
    
    func isDueToday() -> Bool {
        if let due = dueDate {
            return Calendar.current.isDateInToday(due)
        }
        return false
    }
}
