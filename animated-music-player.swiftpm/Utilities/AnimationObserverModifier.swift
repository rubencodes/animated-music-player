//
//  AnimationObserverModifier.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 12/11/22.
//

import SwiftUI

/// Adapted from Antoine van der Lee's `AnimationCompletionObserverModifier`
/// https://www.avanderlee.com/swiftui/withanimation-completion-callback/
struct AnimationObserverModifier<Value>: AnimatableModifier where Value: VectorArithmetic {

    // MARK: - Internal Properties

    var animatableData: Value { didSet { updateState() } }

    // MARK: - Private Properties

    private var targetValue: Value
    private var currentState: Binding<Value>
    private var completion: ((_ newValue: Value) -> Void)?

    // MARK: - Lifecycle

    init(observedValue: Value,
         currentState: Binding<Value>,
         completion: ((_ newValue: Value) -> Void)? = nil) {
        animatableData = observedValue
        targetValue = observedValue
        self.currentState = currentState
        self.completion = completion
    }

    // MARK: - Internal Functions

    func body(content: Content) -> some View {
        content
    }

    // MARK: - Private Functions

    private func updateState() {
        DispatchQueue.main.async {
            currentState.wrappedValue = animatableData

            let isComplete = animatableData == targetValue
            if isComplete {
                completion?(targetValue)
            }
        }
    }
}
