//
//  ViewAllTasks.swift
//  PlanPerfect
//
//  Created by Elizaveta Vygovskaia on 2023-03-24.
//

import SwiftUI
import CoreData

struct ViewAllTasks: View {
    @State var selectedItem: TaskItem?
    @State var showingSheet = false
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.dueDate, ascending: true)],
        animation: .default)
    private var items: FetchedResults<TaskItem>
    
    @Environment(\.presentationMode) var presentationMode: Binding
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "chevron.backward") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color(red: 27/255, green: 209/255, blue: 161/255))
        }
    }
    }
  
    
    var body: some View {
        
        VStack {
            List {
                ForEach(items) { item in
                    if !item.isCompleted(){
                        TaskViewCell(passedTaskItem: item, color: Color(red: 27/255, green: 209/255, blue: 161/255))
                            .environmentObject(dateHolder)
                            .swipeActions(allowsFullSwipe: false){
                                Button("Delete"){
                                    deleteItems(offsets: IndexSet(integer: items.firstIndex(of: item)!))
                                }
                                .lineSpacing(22)
                                .frame(width: 74, height: 44)
                                .tint(Color.red)
                                
                                Button("Edit"){
                                    selectedItem = item
                                    showingSheet.toggle()
                                }
                                .lineSpacing(22)
                                .frame(width: 74, height: 44)
                                .tint(Color(red: 0.33, green: 0.63, blue: 1))
                                
                                
                            }
                            .foregroundColor(Color.white)
                            .listRowBackground(Color.black)
                            .listRowSeparatorTint(Color(red: 38/255, green: 38/255, blue: 38/255))
                    }
                }
                .background(Color.black.edgesIgnoringSafeArea(.all))
                
                Text("Completed")
                    .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.57))
                    .listRowBackground(Color.black)
                    .listRowSeparatorTint(Color.black)
                    .padding(.top, 25)
                    .padding(.bottom, 10)
                    .font(.system(size: 18))
                
                ForEach(items) { item in
                    if item.isCompleted(){
                        TaskViewCell(passedTaskItem: item, color:Color(red: 0.55, green: 0.55, blue: 0.57))
                            .environmentObject(dateHolder)
                            .swipeActions(allowsFullSwipe: false){
                                Button("Delete"){
                                    deleteItems(offsets: IndexSet(integer: items.firstIndex(of: item)!))
                                }
                                .lineSpacing(22)
                                .frame(width: 74, height: 44)
                                .tint(Color.red)
                                
                                Button("Edit"){
                                    selectedItem = item
                                    showingSheet.toggle()
                                }
                                .lineSpacing(22)
                                .frame(width: 74, height: 44)
                                .tint(Color(red: 0.33, green: 0.63, blue: 1))
                                
                                
                            }
                            .foregroundColor(Color.white)
                            .listRowBackground(Color.black)
                            .listRowSeparatorTint(Color(red: 38/255, green: 38/255, blue: 38/255))
                    }
                }
                .background(Color.black.edgesIgnoringSafeArea(.all))
            }
            .listStyle(.plain) // Add this line to remove the default list style
            .foregroundColor(Color.white)
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $showingSheet) {
                BottomSheetView(passedTaskItem: selectedItem, initialDate: Date())
                    .environmentObject(dateHolder)
            }
            .padding(.top, 15)
        }
        .navigationBarTitle("All")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .onAppear(perform: {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(red: 27/255, green: 209/255, blue: 161/255, alpha: 1.0)]
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red: 27/255, green: 209/255, blue: 161/255, alpha: 1.0)]

        })
        .onDisappear(perform: {
            UINavigationBar.appearance().largeTitleTextAttributes = nil
            UINavigationBar.appearance().titleTextAttributes = nil
        })
        
    }
    
    private func deleteItems(offsets: IndexSet = IndexSet()) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            dateHolder.saveContext(viewContext)
        }
    }
    
    func updateNavigationBarColor() {
            
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(red: 27/255, green: 209/255, blue: 161/255, alpha: 1.0)]
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red: 27/255, green: 209/255, blue: 161/255, alpha: 1.0)]
        }
}
    struct ViewAllTasks_Previews: PreviewProvider {
        static var previews: some View {
            ViewAllTasks()
        }
    }
    

