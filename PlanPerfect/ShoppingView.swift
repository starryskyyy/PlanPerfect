//
//  ShoppingView.swift
//  PlanPerfect
//
//  Created by Danesh Zhao-Graham on 2023-04-15.
//

import SwiftUI

struct ShoppingView: View {
    
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
            Image(systemName: "chevron.backward")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color(red: 0.61, green: 0.31, blue: 0.87))
        }
    }
    }

    var body: some View {
        VStack {
            List {
                ForEach(items) { item in
                    if item.isCategory(selectedCategory: "Shopping"){
                        TaskViewCell(passedTaskItem: item, color: Color(red: 0.61, green: 0.31, blue: 0.87))
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
        .navigationBarTitle("Shopping")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .onAppear(perform: {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.61, green: 0.31, blue: 0.87, alpha: 1.0)]
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red: 0.61, green: 0.31, blue: 0.87, alpha: 1.0)]

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

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingView()
    }
}