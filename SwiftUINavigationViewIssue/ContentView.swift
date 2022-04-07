//
//  ContentView.swift
//  SwiftUINavigationViewIssue
//
//  Created by Gene Bogdanovich on 7.04.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @SectionedFetchRequest(
        sectionIdentifier: \.monthAndYear, sortDescriptors: [SortDescriptor(\.timestamp)]
    ) private var items: SectionedFetchResults<String, Item>
    
    var body: some View {
        NavigationView {
            List(items) { section in
                Section(header: Text(section.id)) {
                    ForEach(section) { item in
                        NavigationLink {
                            ItemDetail(item: item)
                        } label: {
                            Text(item.timestamp!.formatted())
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
