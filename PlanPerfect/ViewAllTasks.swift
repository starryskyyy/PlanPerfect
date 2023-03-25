//
//  ViewAllTasks.swift
//  PlanPerfect
//
//  Created by Danesh Zhao-Graham on 2023-03-24.
//

import SwiftUI
import CoreData

struct ViewAllTasks: View {
    
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
    
    init() {
                let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 27/255, green: 209/255, blue: 161/255, alpha: 1.0)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(red: 27/255, green: 209/255, blue: 161/255, alpha: 1.0)]
              }
    
    var body: some View {
        VStack {
            List {
                ForEach(items) { item in
                    Text("Item at \(item.dueDate!, formatter: itemFormatter)")
                        .foregroundColor(Color.white)
                        .listRowBackground(Color.black)
                        .listRowSeparatorTint(Color(red: 38/255, green: 38/255, blue: 38/255))
                }
                .onDelete(perform: deleteItems)
                .background(Color.black.edgesIgnoringSafeArea(.all))
            }
            .listStyle(.plain) // Add this line to remove the default list style
            .foregroundColor(Color.white)
            .background(Color.black.edgesIgnoringSafeArea(.all))
            
            
        }
        .navigationBarTitle("All")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }

   

    fileprivate func saveContext(_ context: NSManagedObjectContext) {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            dateHolder.saveContext(viewContext)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


struct ViewAllTasks_Previews: PreviewProvider {
    static var previews: some View {
        ViewAllTasks()
    }
}

