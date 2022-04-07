//
//  DateEditor.swift
//  SwiftUINavigationViewIssue
//
//  Created by Gene Bogdanovich on 7.04.22.
//

import SwiftUI

// MARK: - DateEditor

public struct DateEditor: View {
    @Environment(\.dismiss) private var dismiss
    @Binding private var date: Date
    private let title = "Edit Date"
    
    public init(date: Binding<Date>) {
        _date = date
    }
    
    public var body: some View {
        NavigationView {
            
            VStack {
                DatePicker(title, selection: $date, in: ...Date.now)
                    .datePickerStyle(.graphical)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    confirmationButton
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var confirmationButton: some View {
        Button("Done") {
            dismiss()
        }
    }
}

// MARK: - DateEditor_Previews

struct DateEditor_Previews: PreviewProvider {
    static var previews: some View {
        DateEditor(date: .constant(Date.now))
    }
}
