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
    @Published private(set) var isCategoriesEmpty: Bool = false
    @Published private(set) var searchText: String = ""
    
    // MARK: - SUBJECTS
    private(set) var frameUpdated = PassthroughSubject<IndexPath, Never>()
    
    // MARK: - STATES
    @Published private(set) var backButtonState: BackButtonState = .toCatalog
    @Published private(set) var emptyLabelState: EmptyLabelState = .search
    @Published private(set) var headerTitleState: HeaderTitleState = .catalog
    @Published private(set) var searchButtonState: ButtonState = .off
    @Published private(set) var switchButtonState: ButtonState = .off
    
    private var normalizedText: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private let categoryRepository: CategoryRepository
    private let frameRepository: FrameRepository
    
    // MARK: - INIT
    init(categoryRepository: CategoryRepository, frameRepository: FrameRepository) {
        self.categoryRepository = categoryRepository
        self.frameRepository = frameRepository
        
        // PUBLISHED PROPERTIES
        $searchText
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { [weak self] searchedText in
                guard let self else { return }
                
                normalizedText.isEmpty ? loadCategories(isFavourite: switchButtonState.isActive) : loadSearchedCategories(text: normalizedText, isFavourite: switchButtonState.isActive)
            }
            .store(in: &cancellables)
        
        $switchButtonState
            .sink { [weak self] state in
                guard let self else { return }
                
                if searchButtonState.isActive, !normalizedText.isEmpty {
                    loadSearchedCategories(text: normalizedText, isFavourite: state.isActive)
                } else {
                    loadCategories(isFavourite: state.isActive)
                }
            }
            .store(in: &cancellables)
        
        $searchButtonState
            .sink { [weak self] state in
                guard let self else { return }
                
                headerTitleState = state.isActive ? .search : (switchButtonState.isActive ? .favourites : .catalog)
                emptyLabelState = state.isActive ? .search : .favourites
            }
            .store(in: &cancellables)
    }
    
    // MARK: - METHODS
    func setup() {
        loadCategories(isFavourite: false)
    }

    func userDidStartSearching(text: String) {
        self.searchText = text
    }
    
    func backButtonTapped() {
        switch backButtonState {
        case .reset:
            self.searchText = ""
            loadCategories(isFavourite: switchButtonState.isActive)
            backButtonState = switchButtonState.isActive ? .toFavourites : .toCatalog
        default:
            self.searchButtonState = .off
            backButtonState = .none
        }
    }
    
    func switchButtonTapped() {
        switchButtonState = switchButtonState == .on ? .off : .on
        
        if searchButtonState.isActive, backButtonState != .reset {
            backButtonState = switchButtonState.isActive ? .toFavourites : .toCatalog
        }
        
        if !searchButtonState.isActive {
            self.headerTitleState = switchButtonState.isActive ? .favourites : .catalog
        }
        
    }
    
    func searchButtonTapped() {
        self.backButtonState = switchButtonState.isActive ? .toFavourites : .toCatalog
        self.searchButtonState = .on
    }
    
    func cellTapped(indexPath: IndexPath) {
        let frame = self.categories[indexPath.section].frames[indexPath.row]
        updateFavourite(for: frame, indexPath: indexPath)
    }
    
    func getFrameViewModel(indexPath: IndexPath) -> CatalogCellViewModel {
        let frame = self.categories[indexPath.section].frames[indexPath.row]
        let viewModel = CatalogCellViewModel(frame: frame)
        
        return viewModel
    }
    
    // MARK: - PRIVATE METHODS
    
    private func loadSearchedCategories(text: String, isFavourite: Bool) {
        print(#function)
        self.categoryRepository.fetch(text: text, isFavourite: isFavourite, searchType: nil)
            .sink { [weak self] value in
                self?.categories = value
                self?.backButtonState = .reset
                self?.isCategoriesEmpty = value.isEmpty
            }
            .store(in: &cancellables)
    }
    
    private func loadCategories(isFavourite: Bool) {
        categoryRepository.fetchAll(isFavourite: isFavourite)
            .sink { [weak self] value in
                self?.categories = value
                self?.isCategoriesEmpty = value.isEmpty
                
            }.store(in: &cancellables)
    }
    
    private func updateFavourite(for frame: Frame, indexPath: IndexPath) {
        self.frameRepository.updateFavourite(for: frame)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.frameUpdated.send(indexPath)
                case .failure(_):
                    break
                }
            }, receiveValue: { [weak self] frame in
                guard let self = self,
                      let categoryIndex = self.categories.firstIndex(where: { $0.frames.contains(frame)}),
                      let frameIndex = self.categories[categoryIndex].frames.firstIndex(where: { $0 == frame })
                else { return }
                
                if self.switchButtonState.isActive, !frame.isFavourite {
                    // disappear effect in switchMode
                    self.categories[categoryIndex].frames.remove(at: frameIndex)
                    
                    if self.categories[categoryIndex].frames.isEmpty {
                        self.categories.remove(at: categoryIndex)
                    }
                } else {
                    self.categories[categoryIndex].frames[frameIndex] = frame
                }
                
                self.isCategoriesEmpty = self.categories.isEmpty
                
            })
            .store(in: &cancellables)
    }
}
