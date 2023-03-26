//
//  CheckBox.swift
//  PlanPerfect
//
//  Created by Danesh Zhao-Graham on 2023-03-25.
//

import SwiftUI

struct CheckBox: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: TaskItem
    var color: Color
    
    var body: some View {
        Image(systemName: passedTaskItem.isCompleted() ? "circle.inset.filled" : "circle")
            .foregroundColor(passedTaskItem.isCompleted() ?  Color(red: 0.55, green: 0.55, blue: 0.57)
 : color)
            .onTapGesture{
                withAnimation{
                    if !passedTaskItem.isCompleted(){
                        passedTaskItem.completeDate = Date()
                       
                    }
                    else{
                        passedTaskItem.completeDate = nil
                    }
                    dateHolder.saveContext(viewContext)
                }
            }
        
    }
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        CheckBox(passedTaskItem:   TaskItem(), color: .blue)
    }
}
