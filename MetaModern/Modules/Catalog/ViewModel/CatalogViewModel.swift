//
//  CatalogViewModel.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 02.07.2025.
//

import Foundation
import Combine

// MARK: - CatalogViewModel
final class CatalogViewModel {
    // MARK: - DATA
    @Published private(set) var categories: [Category] = []
    @Published private(set) var isLoading: Bool = false
    
    let searchPublisher = PassthroughSubject<String, Never>()
    
    
    private var cancellables = Set<AnyCancellable>()
    private var categoryRepository: CategoryRepository
    
    // MARK: - INIT
    init(categoryRepository: CategoryRepository) {
        self.categoryRepository = categoryRepository
    }
    
    // MARK: - METHODS
    func setup() {
        loadCategories()
    }
    
    // MARK: - PRIVATE METHODS
    private func bind() {
        // bind search publisher
    }
    
    private func loadCategories() {
        isLoading = true
        categoryRepository.fetchAll()
            .handleEvents(
                receiveSubscription: { [weak self] _ in self?.isLoading = true },
                receiveCompletion: { [weak self] _ in self?.isLoading = false }
            )
            .sink { [weak self] value in
            self?.categories = value
        }.store(in: &cancellables)
    }
}
