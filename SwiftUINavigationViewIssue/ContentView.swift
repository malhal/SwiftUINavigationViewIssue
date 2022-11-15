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
    
    @State private var selectedItem: Item? // Single selection.
    
    var body: some View {
        NavigationSplitView {
            List(items, selection: $selectedItem) { section in
                Section(header: Text(section.id)) {
                    ForEach(section) { item in
                        NavigationLink(value: item) {
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
        } detail: {
            if let item = selectedItem {
                ItemDetail(item: item)
            }
            else {
                Text("Select Item")
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
