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
}
