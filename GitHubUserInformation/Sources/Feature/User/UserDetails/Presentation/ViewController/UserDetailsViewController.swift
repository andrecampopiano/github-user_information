//
//  UserDetailsViewController.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 23/05/23.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let navigationTitle: String = LocalizableBundle.userDetaisViewControllerNavigationTitle.localize
    }
    
    // MARK: - Properties
    
    private var viewModel: UserDetailsViewModelProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(GenericItemCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.accessibilityIdentifier = HomeViewControllerIdentifiers.tableView.rawValue
        return tableView
    }()
    
    // MARK: - Instantiate
    
    static func instantiate(viewModel: UserDetailsViewModelProtocol) -> UserDetailsViewController {
        let viewController = UserDetailsViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel?.fetchUserDetails()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        bindElements()
        setupLayout()
    }
    
    private func bindElements() {
        viewModel?.status.bind { [weak self] _ in
            guard let self = self else { return }
            self.reloadData()
        }
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.title = self.viewModel?.model?.title ?? Constants.navigationTitle
        }
    }
    
    private func setupLayout() {
        setupProperties()
        setupTableViewLayout()
    }
    
    private func setupProperties() {
        view.backgroundColor = .neutralWhite
    }
    
    private func setupTableViewLayout() {
        view.addSubview(tableView)
        tableView.anchor(top: view.safeTopAnchor, bottom: view.safeBottomAnchor)
        tableView.anchor(left: view.safeLeftAnchor, right: view.safeRightAnchor)
    }
}

extension UserDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.status.value == .loaded ? viewModel?.model?.item?.count ?? .zero : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(GenericItemCell.self, for: indexPath)
        let viewModel = GenericItemCellViewModel(model: self.viewModel?.model?.item?[indexPath.row])
        cell.setup(viewModel: viewModel)
        return cell
    }
}

extension UserDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard self.viewModel?.status.value == .loaded else { return nil }
        let view = GenericCell.instantiate()
        let viewModel = GenericCellViewModel(model: GenericCellModel(title: viewModel?.model?.title,
                                                                     subtitle: viewModel?.model?.subtitle,
                                                                     imageUrl: viewModel?.model?.imageUrl,
                                                                     description: viewModel?.model?.description))
        view.setup(viewModel: viewModel)
        return self.viewModel?.status.value == .loaded ? view : nil
    }
}
