//
//  Extension+View.swift
//  Music ✨
//
//  Created by Ruben Martinez Jr. on 10/14/22.
//

import SwiftUI

extension View {
    func animationObserver<Value: VectorArithmetic>(for value: Value,
                                                    currentState: Binding<Value>,
                                                    completion: ((_ newValue: Value) -> Void)? = nil) -> ModifiedContent<Self, AnimationObserverModifier<Value>> {
        modifier(AnimationObserverModifier(observedValue: value,
                                           currentState: currentState,
                                           completion: completion))
    }
}
