//
//  SearchStore.swift
//  StackOv
//
//  Created by Erik Basargin on 11/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class SearchStore: ObservableObject {
    // MARK: - Parameters
    
    @Published private(set) var query: String = ""
    @Published private(set) var isEditing: Bool = false
    
    private var cancelBag: Set<AnyCancellable> = []
    
    // MARK: - Initializing and deinitializing
    
    init() {
        NotificationCenter.default
            .publisher(for: .keyboardWillHide)
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
                self.endEditing()
            }
            .store(in: &cancelBag)
    }
    
    deinit {
        cancelBag.forEach { $0.cancel() }
    }
    
    // MARK: - Methods
    
    func search(query: String) {
        self.query = query
    }
    
    func search(tag: TagModel) {
        query = tag.name
    }
    
    func clean() {
        query = ""
    }
    
    func startEditing() {
        isEditing = true
    }
    
    func endEditing() {
        isEditing = false
    }
}
