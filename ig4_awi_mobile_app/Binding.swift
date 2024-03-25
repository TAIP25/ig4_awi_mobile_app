//
//  Binding.swift
//  test
//
//  Created by etud on 24/03/2024.
//

import SwiftUI

extension Binding {
    public func defaultValue<T>(_ value: T) -> Binding<T> where Value == Optional<T> {
        Binding<T> {
            wrappedValue ?? value
        } set: {
            wrappedValue = $0
        }
    }
}
