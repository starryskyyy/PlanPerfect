//
//  TaskViewCell.swift
//  PlanPerfect
//
//  Created by Elizaveta Vygovskaia on 2023-03-25.
//

import SwiftUI

struct TaskViewCell: View {
    
    
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: TaskItem
    
    var color: Color
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            HStack {
                CheckBox(passedTaskItem: passedTaskItem, color: color)
                    .environmentObject(dateHolder)
                Text(passedTaskItem.name ?? "")
                    .padding(.horizontal)
                    .foregroundColor(passedTaskItem.isCompleted() ?  color : Color.white)
                Spacer()
                if passedTaskItem.isCompleted() {
                    Text("Completed\n\(passedTaskItem.completeDate!.formatted(date: .abbreviated, time: .shortened))")
                        .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.57))
                        .font(.system(size: 12))
                        .multilineTextAlignment(.leading)
                }
                else if !passedTaskItem.isCompleted() && (passedTaskItem.scheduleDate || passedTaskItem.scheduleTime){
                    if !passedTaskItem.scheduleTime {
                        Text(passedTaskItem.dueDate!.formatted(date: .abbreviated, time: .omitted))
                            .foregroundColor(passedTaskItem.overDueColor(color: color))
                            .font(.footnote)
                            .padding(.top, 1)
                    } else {
                        Text(passedTaskItem.dueDate!.formatted(date: .abbreviated, time: passedTaskItem.scheduleTime ? .shortened : .omitted))
                            .foregroundColor(passedTaskItem.overDueColor(color: color))
                            .font(.footnote)
                            .padding(.top, 1)
                    }
                }

            }
            
            if let desc = passedTaskItem.desc, !desc.isEmpty && !passedTaskItem.isCompleted(){
                Text(desc)
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 2)
            }
            Spacer()
        }
    }
}

struct TaskViewCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskViewCell(passedTaskItem: TaskItem(), color: .blue)
    }
}
