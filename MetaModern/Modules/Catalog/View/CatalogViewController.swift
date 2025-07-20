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
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - GUI
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.sectionHeaderTopPadding = 0
        tableView.register(CatalogTableViewCell.self, forCellReuseIdentifier: "CatalogTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.font = DSFont.title3(weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var searchTextField: CatalogSearchTextField = {
        let textField = CatalogSearchTextField(padding: DSSpasing.leading)
        textField.autocapitalizationType = .sentences
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.placeholder = L10n.Catalog.textFieldPlaceholder
        
        return textField
    }()
    
    private let backButton = DSButton()
    private let activityIndicatorView = UIActivityIndicatorView()
    private let headerView = SecondaryHeaderView()
    private let switchButton = UIButton()
    private let searchButton = UIButton()
    
    // MARK: - CONSTRAINTS
    private lazy var searchTextFieldHeightAnchor = searchTextField.heightAnchor.constraint(equalToConstant: self.view.frame.height * DSLayout.CatalogSearchTextFieldLayot.heightRatio)
    private lazy var searchTextFieldZeroHeightAnchor = searchTextField.heightAnchor.constraint(equalToConstant: 0)
    
    private lazy var backButtonHeightAnchor = backButton.heightAnchor.constraint(equalToConstant: self.view.frame.height * DSLayout.DSButton.heightRatio)
    private lazy var backButtonZeroHeightAnchor = backButton.heightAnchor.constraint(equalToConstant: 0)
    
    private lazy var tableViewBottomAnchor = tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
    
    private lazy var tableViewBottomAnchorToBackButton = tableView.bottomAnchor.constraint(equalTo: self.backButton.topAnchor)
    
    private lazy var backButtonBottomAnchorConstraint = backButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
    
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
        configureSearchTextFieldLayout()
        configureTableViewLayout()
        configureBackButtonLayout()
        configureActivityIndicatorViewLayout()
        configureEmptyLabelLayout()
        
        setupTargets()
        setupHeaderViewButtons()
        setupBindingsViewModel()
        setupGestureRecognizers()
        
        self.viewModel.setup()
        
    }
    
    // MARK: - PRIVATE METHODS
    private func setupHeaderViewButtons() {
        // SEARCH BUTTON
        let searchButtonContainer = UIView()
        searchButtonContainer.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.centerXAnchor.constraint(equalTo: searchButtonContainer.centerXAnchor),
            searchButton.centerYAnchor.constraint(equalTo: searchButtonContainer.centerYAnchor),
            searchButton.heightAnchor.constraint(equalTo: searchButtonContainer.heightAnchor,
                                                 multiplier: DSLayout.CatalogViewControllerLayout.seatchButtonHeightRatio),
            searchButton.widthAnchor.constraint(equalTo: searchButton.heightAnchor)
        ])
        self.headerView.appendViewToButtonsStackView(searchButtonContainer)
        searchButton.setImage(UIImage.DS.Buttons.search, for: .normal)
        
        // SWITCH BUTTON
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
    }
    private func setupTargets() {
        self.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        self.switchButton.addTarget(self, action: #selector(switchButtonTapped), for: .touchUpInside)
        
        self.searchTextField.addTarget(self, action: #selector(searchTextFieldEdited), for: .editingChanged)
        self.searchTextField.addTarget(self, action: #selector(searchTextFieldReturnButtonTapped), for: .editingDidEndOnExit)
        
        self.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func setupGestureRecognizers() {
        let viewTGR = UITapGestureRecognizer(target: self, action: #selector(baseEndEditing))
        viewTGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(viewTGR)
    }
    
    private func setupBindingsViewModel() {
        self.viewModel.$switchButtonState
            .sink { [weak self] state in
                let image = state == .on ? UIImage.DS.Buttons.switchOn : UIImage.DS.Buttons.switchOff
                self?.switchButton.setImage(image, for: .normal)
                
            }
            .store(in: &cancellables)
        
        self.viewModel.$categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        self.viewModel.$backButtonState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.backButton.setTitle(state.title, for: .normal)
            }
            .store(in: &cancellables)
        
        self.viewModel.$searchButtonState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                
                state.isActive ? activateSearchModeLayout() : activateCatalogModeLayout()
            }
            .store(in: &cancellables)

        
        self.viewModel.frameUpdated
            .sink { [weak self] indexPath in
                DispatchQueue.main.async {
                    self?.tableView.reloadRows(at: [indexPath], with: .fade)
                }
            }
            .store(in: &cancellables)
        
        self.viewModel.$searchText
            .filter { $0.isEmpty }
            .sink { [weak self] text in
                self?.searchTextField.text = text
            }
            .store(in: &cancellables)
        
        self.viewModel.$isCategoriesEmpty
            .sink { [weak self] isEmpty in
                DispatchQueue.main.async {
                    self?.emptyLabel.isHidden = !isEmpty
                }
            }
            .store(in: &cancellables)
        
        self.viewModel.$emptyLabelState
            .sink { [weak self] state in
                self?.emptyLabel.text = state.title
            }
            .store(in: &cancellables)
        
        self.viewModel.$headerTitleState
            .sink { [weak self] state in
                self?.headerView.setTitle(state.title)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - @OBJC PRIVATE METHODS
    @objc private func searchButtonTapped() {
        self.viewModel.searchButtonTapped()
    }
    
    @objc private func switchButtonTapped() {
        self.viewModel.switchButtonTapped()
    }
    
    @objc private func backButtonTapped() {
        self.viewModel.backButtonTapped()
    }
    
    @objc private func searchTextFieldEdited(_ sender: UITextField) {
        guard let text = sender.text else { return }
        self.viewModel.userDidStartSearching(text: text)
    }
    
    @objc private func searchTextFieldReturnButtonTapped() {
        self.searchTextField.resignFirstResponder()
    }
}

// MARK: - Configure Layout
private extension CatalogViewController {
    func activateSearchModeLayout() {
        UIView.animate(withDuration: 0.4) {
            self.searchButton.alpha = 0
        }
        
        self.searchTextFieldZeroHeightAnchor.isActive = false
        self.searchTextFieldHeightAnchor.isActive = true
        
        self.backButtonZeroHeightAnchor.isActive = false
        self.backButtonHeightAnchor.isActive = true
        
        self.backButtonBottomAnchorConstraint.constant = DSSpasing.bottom
        
        self.tableViewBottomAnchor.isActive = false
        self.tableViewBottomAnchorToBackButton.isActive = true
        self.tableViewBottomAnchorToBackButton.constant = DSSpasing.bottom
        
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        
        self.searchTextField.setupRightView()
    }
    
    func activateCatalogModeLayout() {
        UIView.animate(withDuration: 0.4) {
            self.searchButton.alpha = 1
        }
        
        self.searchTextFieldHeightAnchor.isActive = false
        self.searchTextFieldZeroHeightAnchor.isActive = true
        
        self.backButtonHeightAnchor.isActive = false
        self.backButtonZeroHeightAnchor.isActive = true
        
        self.backButtonBottomAnchorConstraint.constant = 0
        
        self.tableViewBottomAnchorToBackButton.isActive = false
        self.tableViewBottomAnchor.isActive = true
        
        self.tableViewBottomAnchorToBackButton.constant = 0
        
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        
        searchTextField.setupRightView()
    }
    
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
    
    func configureSearchTextFieldLayout() {
        self.view.addSubview(searchTextField)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: DSSpasing.medium),
            searchTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: DSSpasing.leading),
            searchTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: DSSpasing.trailing),
            searchTextFieldZeroHeightAnchor
        ])
    }
    
    func configureTableViewLayout() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableViewBottomAnchor
        ])
    }
    
    func configureBackButtonLayout() {
        self.view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: DSLayout.DSButton.widthRatio),
            backButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            backButtonBottomAnchorConstraint,
            backButtonZeroHeightAnchor
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
    
    func configureEmptyLabelLayout() {
        self.tableView.addSubview(emptyLabel)
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyLabel.topAnchor.constraint(equalTo: self.tableView.topAnchor, constant: DSSpasing.large),
            emptyLabel.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
            emptyLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: DSLayout.CatalogViewControllerLayout.emptyLabelWidthRatio)
        ])
    }
}
