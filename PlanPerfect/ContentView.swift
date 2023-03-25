//
//  ContentView.swift
//  PlanPerfect
//
//  Created by Danesh Zhao-Graham on 2023-03-24.
//

import SwiftUI
import CoreData

struct BottomSheetView: View{
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var dateHolder: DateHolder
    
    @State var selectedTaskItem: TaskItem?
    @State var name: String
    @State var desc: String
    @State var dueDate: Date
    @State var dueTime: Date
    @State var scheduleTime: Bool
    @State var scheduleDate: Bool
    
    
    
    init(passedTaskItem: TaskItem?, initialDate: Date){
        if let taskItem = passedTaskItem{
            _selectedTaskItem = State(initialValue: taskItem)
            _name = State(initialValue: taskItem.name ?? "")
            _desc = State(initialValue: taskItem.desc ?? "")
            _dueDate = State(initialValue: taskItem.dueDate ?? initialDate)
            _dueTime = State(initialValue: taskItem.dueTime ?? initialDate)
            _scheduleTime = State(initialValue: taskItem.scheduleTime)
            _scheduleDate = State(initialValue: taskItem.scheduleDate)
            
        }
        else{
            _name = State(initialValue: "")
            _desc = State(initialValue: "")
            _dueDate = State(initialValue: initialDate)
            _dueTime = State(initialValue: initialDate)
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
                        .frame(width: 337, height: 135)
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
                        DatePicker("", selection: $dueTime, displayedComponents: [.hourAndMinute])
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
        if selectedTaskItem == nil
        {
            selectedTaskItem = TaskItem(context: viewContext)
        }
        
        selectedTaskItem?.created = Date()
        selectedTaskItem?.name = name
        selectedTaskItem?.dueDate  = dueDate
        selectedTaskItem?.dueTime  = dueTime
        selectedTaskItem?.scheduleDate = scheduleDate
        selectedTaskItem?.scheduleTime = scheduleTime
        
        dateHolder.saveContext(viewContext)
        
        self.presentationMode.wrappedValue.dismiss()
        
    }
        
    
}


struct ContentView: View {
    @State var showingSheet = false
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                
                
                HStack(alignment: .top) { // Add alignment to leading
                    Button("New Task") {
                        showingSheet.toggle()
                    }
                    .fontWeight(.bold)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .frame(width: 100, height: 15)
                    .padding(.vertical)
                    .background(Color(red: 0.02, green: 0.20, blue: 0.15, opacity: 0.50))
                    .cornerRadius(9)
                    Spacer() // Add Spacer after the Button
                }
                
                .foregroundColor(Color(red: 27/255, green: 209/255, blue: 161/255))
                
                NavigationLink(destination: ViewAllTasks())
                {
                    
                    HStack {
                        Text("All")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fontWeight(.bold)
                        
                        Image(systemName: "arrow.right.circle")
                            .padding(.trailing, 8)
                    }
                    
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 11)
                .frame(width: 390, height: 53)
                .background(Color(red: 0.15, green: 0.15, blue: 0.15, opacity: 0.50))
                .contentShape(Rectangle())
                .cornerRadius(12)
                .foregroundColor(Color(red: 27/255, green: 209/255, blue: 161/255))
                
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .sheet(isPresented: $showingSheet) {
                BottomSheetView(passedTaskItem: nil, initialDate: Date()).environmentObject(dateHolder)
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
