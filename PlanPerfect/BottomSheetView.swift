//
//  BottomSheetView.swift
//  PlanPerfect
//
//  Created by Danesh Zhao-Graham on 2023-03-25.
//

import SwiftUI

struct BottomSheetView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var dateHolder: DateHolder
    
    @State var selectedTaskItem: TaskItem?
    @State var name: String
    @State var desc: String
    @State var dueDate: Date
    @State var scheduleTime: Bool
    @State var scheduleDate: Bool
    
    
    
    init(passedTaskItem: TaskItem?, initialDate: Date){
        if let taskItem = passedTaskItem{
            _selectedTaskItem = State(initialValue: taskItem)
            _name = State(initialValue: taskItem.name ?? "")
            _desc = State(initialValue: taskItem.desc ?? "")
            _dueDate = State(initialValue: taskItem.dueDate ?? initialDate)
            _scheduleTime = State(initialValue: taskItem.scheduleTime)
            _scheduleDate = State(initialValue: taskItem.scheduleDate)
            
        }
        else{
            _name = State(initialValue: "")
            _desc = State(initialValue: "")
            _dueDate = State(initialValue: initialDate)
            _scheduleTime = State(initialValue:false)
            _scheduleDate = State(initialValue:false)
        }
    }
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("", text: $name)
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 11)
                        .frame(width: 337, height: 53)
                        .background(Color(red: 0.25, green: 0.25, blue: 0.25))
                        .cornerRadius(12)
                }
                .foregroundColor(Color(red: 0.553, green: 0.553, blue: 0.573))
                .listRowBackground(Color(#colorLiteral(red: 0.1490196139, green: 0.1490196139, blue: 0.1490196139, alpha: 1)))

                Section(header: Text("Description")) {
                    TextField("", text: $desc)
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 11)
                        .frame(width: 337, height: 135, alignment: .top)
                        .background(Color(red: 0.25, green: 0.25, blue: 0.25))
                        .cornerRadius(12)
                        .multilineTextAlignment(.leading)
                }
                .foregroundColor(Color(red: 0.553, green: 0.553, blue: 0.573))
                .listRowBackground(Color(red: 0.25, green: 0.25, blue: 0.25))

                Section(header: Text("Due Date")) {
                    Toggle("Schedule Date", isOn: $scheduleDate)
                        .foregroundColor(Color.white)
                    if scheduleDate {
                        DatePicker("", selection: $dueDate, displayedComponents: [.date])
                            .colorInvert()
                            .foregroundColor(Color.white)
                    }
                    Toggle("Schedule Time", isOn: $scheduleTime)
                        .foregroundColor(Color.white)
                    if scheduleTime {
                        DatePicker("", selection: $dueDate, displayedComponents: [.hourAndMinute])
                            .colorInvert()
                            .foregroundColor(Color.white)
                    }
                }
                .foregroundColor(Color(red: 0.553, green: 0.553, blue: 0.573))
                .listRowBackground(Color(red: 0.25, green: 0.25, blue: 0.25))
                
            }
            .navigationBarItems(trailing:
                Button(action: {
                    saveAction()
                }, label: {
                    Text("Save")
                        .foregroundColor(Color.white)
                })
            )
            .scrollContentBackground(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 0.1490196139, green: 0.1490196139, blue: 0.1490196139, alpha: 1)).edgesIgnoringSafeArea(.all))
            .onAppear {
                        // assign values of selectedTaskItem to the @State variables
                        if let taskItem = selectedTaskItem {
                            name = taskItem.name ?? ""
                            desc = taskItem.desc ?? ""
                            dueDate = taskItem.dueDate ?? Date()
                            scheduleTime = taskItem.scheduleTime
                            scheduleDate = taskItem.scheduleDate
                        }
                    }
        }
    }

    
    func displayDate() -> DatePickerComponents
    {
        return scheduleDate ? [.date] : []
    }
    
    func displayTime() -> DatePickerComponents
    {
        return scheduleTime ? [.hourAndMinute] : []
    }
    
    func saveAction(){
        withAnimation
        {
            if selectedTaskItem == nil
            {
                selectedTaskItem = TaskItem(context: viewContext)
            }
            
            selectedTaskItem?.created = Date()
            selectedTaskItem?.name = name
            selectedTaskItem?.desc = desc
            selectedTaskItem?.dueDate = dueDate
            selectedTaskItem?.scheduleTime = scheduleTime
            selectedTaskItem?.scheduleDate = scheduleDate
            
            dateHolder.saveContext(viewContext)
            self.presentationMode.wrappedValue.dismiss()
        }
        
    }
    
    
}

struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView(passedTaskItem: TaskItem(), initialDate: Date())
    }
}
