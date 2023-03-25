//
//  ContentView.swift
//  PlanPerfect
//
//  Created by Danesh Zhao-Graham on 2023-03-24.
//

import SwiftUI
import CoreData



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
                        
                        Image(systemName: "chevron.right")
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
