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
            self.title = self.viewModel?.model?.login ?? Constants.navigationTitle
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
#warning("implementar model de apresentação")
        return viewModel?.status.value == .loaded ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension UserDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard self.viewModel?.status.value == .loaded else { return nil }
        let view = GenericCell.instantiate()
        let viewModel = GenericCellViewModel(model: GenericCellModel(title: viewModel?.model?.name,
                                                                     subtitle: viewModel?.model?.company,
                                                                     imageUrl: viewModel?.model?.avatarUrl,
                                                                     description: viewModel?.model?.htmlUrl))
        view.setup(viewModel: viewModel)
        return view
    }
}
