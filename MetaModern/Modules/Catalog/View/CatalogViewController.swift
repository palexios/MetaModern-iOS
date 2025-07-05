//
//  CatalogViewController.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 22.06.2025.
//

import UIKit
import Combine

// MARK: - CatalogViewController
final class CatalogViewController: BaseViewController {
    // MARK: - PROPERTIES
    let viewModel: CatalogViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - GUI
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.sectionHeaderTopPadding = 0
        tableView.register(CatalogTableViewCell.self, forCellReuseIdentifier: "CatalogTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private let activityIndicatorView = UIActivityIndicatorView()
    private let headerView = SecondaryHeaderView()
    private let switchButton = UIButton()
    private let searchButton = UIButton()
    
    // MARK: - INIT
    init(viewModel: CatalogViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHeaderViewLayout()
        configureTableViewLayout()
        configureActivityIndicatorViewLayout()
        
        setupTargets()
        setupHeaderViewButtons()
        setupBindingsViewModel()
        
        self.viewModel.setup()
    }
    
    // MARK: - PRIVATE METHODS
    private func setupHeaderViewButtons() {
        let searchButtonContainer = UIView()
        searchButtonContainer.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.centerXAnchor.constraint(equalTo: searchButtonContainer.centerXAnchor),
            searchButton.centerYAnchor.constraint(equalTo: searchButtonContainer.centerYAnchor),
            searchButton.widthAnchor.constraint(equalTo: searchButtonContainer.widthAnchor,
                                                multiplier: DSLayout.CatalogViewControllerLayout.searchButtonWidthRatio),
            searchButton.heightAnchor.constraint(equalTo: searchButtonContainer.heightAnchor,
                                                 multiplier: DSLayout.CatalogViewControllerLayout.seatchButtonHeightRatio)
        ])
        self.headerView.appendViewToButtonsStackView(searchButtonContainer)
        searchButton.setImage(UIImage.DS.Buttons.search, for: .normal)
        
        let switchButtonContainer = UIView()
        switchButtonContainer.addSubview(switchButton)
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            switchButton.centerXAnchor.constraint(equalTo: switchButtonContainer.centerXAnchor),
            switchButton.centerYAnchor.constraint(equalTo: switchButtonContainer.centerYAnchor),
            switchButton.widthAnchor.constraint(equalTo: switchButtonContainer.widthAnchor,
                                                multiplier: DSLayout.CatalogViewControllerLayout.switchButtonWidthRatio),
            switchButton.heightAnchor.constraint(equalTo: switchButtonContainer.heightAnchor,
                                                 multiplier: DSLayout.CatalogViewControllerLayout.switchButtonHeightRatio)
        ])
        self.headerView.appendViewToButtonsStackView(switchButtonContainer)
        switchButton.setImage(UIImage.DS.Buttons.switchOff, for: .normal)
    }
    private func setupTargets() {
        self.switchButton.addTarget(self, action: #selector(switchButtonTapped), for: .touchUpInside)
    }
    
    private func setupBindingsViewModel() {
        self.viewModel.$categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
            self?.tableView.reloadData()
        }.store(in: &cancellables)
        
        self.viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                isLoading ? self?.activityIndicatorView.startAnimating() : self?.activityIndicatorView.stopAnimating()
            }
            .store(in: &cancellables)
    }
    
    private func makeSearchAlertController() {
        let alertController = UIAlertController(title: L10n.Catalog.alertControllerTitle, message: L10n.Catalog.alertControllerMessage, preferredStyle: .alert)
        alertController.addTextField() { [weak self] textField in
            guard let self = self else { return }
            
            textField.delegate = self
        }
        
        let cancelAction = UIAlertAction(title: L10n.Catalog.alertControllerCancelActionTitle, style: .cancel)
        let searchAction = UIAlertAction(title: L10n.Catalog.alertControllerSearchActionTitle, style: .default) { [weak self] _ in
            
        }
    }
    
    // MARK: - @OBJC PRIVATE METHODS
    @objc private func switchButtonTapped() {
        
    }
}

// MARK: - Configure Layout
private extension CatalogViewController {
    func configureHeaderViewLayout() {
        self.view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: DSLayout.SecondaryHeaderViewLayout.heightRatio)
        ])
    }
    
    func configureTableViewLayout() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: DSSpasing.bottom)
        ])
    }
    
    func configureActivityIndicatorViewLayout() {
        self.tableView.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor)
        ])
    }
}
