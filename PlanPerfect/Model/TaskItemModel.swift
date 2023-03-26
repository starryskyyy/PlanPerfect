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
    
    func isOverdue() -> Bool {
        guard let dueDate = dueDate else { return false }
        let currentDate = Date()
        let calendar = Calendar.current
        
        if !isCompleted() && (scheduleDate || scheduleTime) {
            if calendar.isDateInToday(dueDate) {
                if !scheduleTime { return false }
                return currentDate > dueDate
            } else {
                return dueDate < currentDate
            }
        }
        return false
    }


    
    func overDueColor(color: Color) -> Color{
        return isOverdue() ? Color(red: 1, green: 0.27, blue: 0.23) : color
    }
    
    func isDueToday() -> Bool {
        if let due = dueDate {
            return Calendar.current.isDateInToday(due) && !isCompleted() && scheduleDate
        }
        return false
    }
    
    func isScheduled() -> Bool{
        return !isOverdue() && !isCompleted()
    }
}
