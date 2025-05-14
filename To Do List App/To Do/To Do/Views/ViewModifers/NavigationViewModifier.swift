//
//  NavigationViewModifier.swift
//  To Do
//
//  Created by Saad Ahmad on 5/13/25.
//

import Foundation
import SwiftUI

/// View Modifier for Navigation Bar
struct NavigationViewModifier: ViewModifier {
    let title: String
    let onCancel: () -> Void
    let onConfirm: () -> Void
    let cancelText: String
    let confirmText: String
    let onCancelDisabled: Bool
    let onConfirmDisabled: Bool
    let onAppear: (() -> Void)?

    func body(content: Content) -> some View {
        NavigationView {
            content
                .navigationBarTitle(title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(cancelText, action: onCancel)
                            .disabled(onCancelDisabled)
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button(confirmText, action: onConfirm)
                            .disabled(onConfirmDisabled)
                    }
                }
                .onAppear { onAppear?() }
        }
    }
}

/// Extension of View
extension View {
    func navigationViewModifier(
        _ title: String,
        onCancel: @escaping () -> Void,
        onConfirm: @escaping () -> Void,
        cancelText: String = "Cancel",
        confirmText: String = "Save",
        onCancelDisabled: Bool = false,
        onConfirmDisabled: Bool = false,
        onAppear: (() -> Void)? = nil
    ) -> some View {
        modifier(
            NavigationViewModifier(
                title: title,
                onCancel: onCancel,
                onConfirm: onConfirm,
                cancelText: cancelText,
                confirmText: confirmText,
                onCancelDisabled: onCancelDisabled,
                onConfirmDisabled: onConfirmDisabled,
                onAppear: onAppear
            )
        )
    }
}
