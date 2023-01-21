//
//  ObservableObject+Generic.swift
//  Common
//
//  Created by Anderson F Carvalho on 20/01/23.
//

import Foundation
import Combine

public class MyObservableObject<T: Hashable>: ObservableObject {
    public init() { }
    public var value = PassthroughSubject<T, Never>()
}
