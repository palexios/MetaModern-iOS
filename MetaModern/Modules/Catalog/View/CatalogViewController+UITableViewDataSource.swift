//
//  CatalogViewController+UITableViewDataSource.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 04.07.2025.
//

import UIKit

// MARK: - UITableViewDataSource
extension CatalogViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.categories[section].frames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CatalogTableViewCell", for: indexPath) as? CatalogTableViewCell else { return UITableViewCell() }
        cell.separatorInset = .zero
        
        let viewModel = self.viewModel.getFrameViewModel(indexPath: indexPath)
        cell.viewModel = viewModel
        
        cell.viewModel?.subscription = viewModel.heartImageViewTappedSubject
            .sink { value in
                self.viewModel.cellTapped(indexPath: indexPath)
            }
        
        cell.setup()
        
        return cell
    }
    
}

