//
//  HomeViewController.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import UIKit

enum HomeViewControllerIdentifiers: String {
    case tableView = "homeViewController_tableView_id"
}

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: HomeViewModelProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerCell(GenericCell.self)
        tableView.registerCell(GenericLoadingCell.self)
        tableView.registerCell(GenericErrorCell.self)
        tableView.accessibilityIdentifier = HomeViewControllerIdentifiers.tableView.rawValue
        return tableView
    }()
    
    // MARK: - Instantiate
    
    static func instantiate(viewModel: HomeViewModelProtocol) -> HomeViewController {
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupDataSource()
    }
    
    // MARK: - Private Methods
    
    private func setupDataSource() {
        bindElements()
        viewModel?.fetchUserList()
    }
    
    private func bindElements() {
        viewModel?.status.bind { [weak self] _ in
            guard let self = self else { return }
            self.reloadData()
        }
    }
    
    private func setupLayout() {
        setupProperties()
        setupTableViewLayout()
    }
    
    private func setupProperties() {
        title = LocalizableBundle.homeViewControllerNavitationTitle.localize
    }
    
    private func setupTableViewLayout() {
        view.addSubview(tableView)
        tableView.anchor(top: view.safeTopAnchor, bottom: view.safeBottomAnchor)
        tableView.anchor(left: view.safeLeftAnchor, right: view.safeRightAnchor)
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.status.value == .loaded ? self.viewModel?.model?.count ?? .zero : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let status = viewModel?.status.value else { return UITableViewCell() }
        switch status {
        case .error:
            return setupGenericErrorCell(tableView, cellForRowAt: indexPath)
        case .loading:
            return setupGenericLoadingCell(tableView, cellForRowAt: indexPath)
        case .loaded:
            return setupGenericCell(tableView, cellForRowAt: indexPath)
        }
    }
    
    private func setupGenericLoadingCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> GenericLoadingCell {
        let cell = tableView.dequeueReusableCell(GenericLoadingCell.self, for: indexPath)
        cell.setup()
        return cell
    }
    
    private func setupGenericCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> GenericCell {
        let cell = tableView.dequeueReusableCell(GenericCell.self, for: indexPath)
        let model = viewModel?.model?[indexPath.row]
        let viewModel = GenericCellViewModel(model: GenericCellModel(title: model?.login, subtitle: model?.htmlUrl, imageUrl: model?.avatarUrl))
        cell.setup(viewModel: viewModel)
        return cell
    }
    
    private func setupGenericErrorCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> GenericErrorCell {
        let cell = tableView.dequeueReusableCell(GenericErrorCell.self, for: indexPath)
        cell.setup(delegate: self)
        return cell
    }
}

// MARK: - GenericErrorCellDelegate
extension HomeViewController: GenericErrorCellDelegate {
    func tryAgain() {
        viewModel?.fetchUserList()
    }
}
