//
//  TodayTaskView.swift
//  PlanPerfect
//
//  Created by Elizaveta Vygovskaia on 2023-03-25.
//

import SwiftUI

struct TodayTaskView: View {
    
    @State private var deletionIndexSet: IndexSet?
    @State private var showingAlert = false

    
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
                .foregroundColor(Color(red: 1, green: 0.84, blue: 0.04))
        }
    }
    }
    
  
    
    var body: some View {
       
        
        VStack {
            List {
                ForEach(items) { item in
                    if item.isDueToday(){
                        TaskViewCell(passedTaskItem: item, color: Color(red: 1, green: 0.84, blue: 0.04))
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
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("Delete Item"),
                        message: Text("Are you sure you want to delete?"),
                        primaryButton: .destructive(Text("Delete")) {
                            onDeleteConfirmed()
                        },
                        secondaryButton: .cancel(Text("Cancel")) {
                            deletionIndexSet = nil
                        }
                    )
                }
            }
            .listStyle(.plain)
            .foregroundColor(Color.white)
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $showingSheet) {
                BottomSheetView(passedTaskItem: selectedItem, initialDate: Date())
                    .environmentObject(dateHolder)
            }
            .padding(.top, 15)
        }
        .navigationBarTitle("Today")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .onAppear(perform: {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(red: 1, green: 0.84, blue: 0.04, alpha: 1)]
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red: 1, green: 0.84, blue: 0.04, alpha: 1)]

        })
        .onDisappear(perform: {
            UINavigationBar.appearance().largeTitleTextAttributes = nil
            UINavigationBar.appearance().titleTextAttributes = nil
        })
        
    }
    
    private func deleteItems(offsets: IndexSet = IndexSet()) {
        if offsets.isEmpty {
            return
        }
        showingAlert = true
        deletionIndexSet = offsets
    }

    private func onDeleteConfirmed() {
        withAnimation {
            deletionIndexSet?.map { items[$0] }.forEach(viewContext.delete)
            dateHolder.saveContext(viewContext)
        }
        deletionIndexSet = nil
    }
  
}

struct TodayTaskView_Previews: PreviewProvider {
    static var previews: some View {
        TodayTaskView()
    }
}
