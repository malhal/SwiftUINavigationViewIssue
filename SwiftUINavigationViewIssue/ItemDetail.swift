//
//  ItemDetail.swift
//  SwiftUINavigationViewIssue
//
//  Created by Gene Bogdanovich on 7.04.22.
//

import SwiftUI

struct ItemDetail: View {
    @ObservedObject var item: Item
    
    @State private var isPresentingDateEditor = false
    
    var body: some View {
        Text("Item at \(item.timestamp!.formatted())")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Button(item.timestamp!.formatted()) {
                        isPresentingDateEditor = true
                    }
                }
            }
            .sheet(isPresented: $isPresentingDateEditor) {
                if let date = Binding($item.timestamp) {
                    DateEditor(date: date)
                }
            }
    }
}
