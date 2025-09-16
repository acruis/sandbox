//
//  FirstAppear.swift
//  ConcurrencySandbox
//
//  Created by Quoc Dat Nguyen on 16/9/25.
//

import SwiftUI

private struct FirstAppear: ViewModifier {
    let action: () -> ()

    @State private var hasAppeared = false

    func body(content: Content) -> some View {
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            action()
        }
    }
}

public extension View {
    func onFirstAppear(_ action: @escaping () -> ()) -> some View {
        modifier(FirstAppear(action: action))
    }
}
