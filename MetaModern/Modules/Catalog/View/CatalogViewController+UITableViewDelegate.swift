//
//  CatalogViewController+UITableViewDelegate.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 04.07.2025.
//

import UIKit

// MARK: - UITableViewDelegate
extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.view.frame.height * DSLayout.CatalogViewControllerLayout.tableViewCellHeightRatio
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = CatalogTableViewHeaderView()
        view.setup(title: self.viewModel.categories[section].name)
        
        return view
    }
}
