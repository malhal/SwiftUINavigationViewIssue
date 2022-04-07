//
//  Item+.swift
//  SwiftUINavigationViewIssue
//
//  Created by Gene Bogdanovich on 7.04.22.
//

import CoreData

extension Item {
    @objc var monthAndYear: String {
        timestamp!.formatted(.dateTime.month().year())
    }
}

