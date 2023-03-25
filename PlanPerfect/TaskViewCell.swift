//
//  TaskViewCell.swift
//  PlanPerfect
//
//  Created by Danesh Zhao-Graham on 2023-03-25.
//

import SwiftUI

struct TaskViewCell: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: TaskItem
    
    var body: some View {
        VStack {
            HStack {
                CheckBox(passedTaskItem: passedTaskItem)
                    .environmentObject(dateHolder)
                Text(passedTaskItem.name ?? "")
                    .padding(.horizontal)
                    .foregroundColor(passedTaskItem.isCompleted() ?  Color(red: 0.55, green: 0.55, blue: 0.57) : Color.white )
                Spacer()
            }
            if passedTaskItem.isCompleted(){
                Text("Completed\n\(passedTaskItem.completeDate!.formatted(date: .abbreviated, time: .shortened))")
                    .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.57))
                    .font(.system(size: 12))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical)
            }
        }
    }
}

struct TaskViewCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskViewCell(passedTaskItem: TaskItem())
    }
}
