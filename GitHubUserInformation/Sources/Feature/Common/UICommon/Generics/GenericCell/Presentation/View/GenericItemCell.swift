//
//  GenericItemCell.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 23/05/23.
//

import CoreSwift
import UIKit

enum GenericItemCellIdentifiers: String {
    case titleLabel = "genericItemCell_titleLabel_id"
    case descriptionLabel = "genericItemCell_descriptionLabel_id"
}

final class GenericItemCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var viewModel: GenericItemCellViewModelProtocol?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: .bold, size: .medium)
        label.textColor = .neutralDarkGrey
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.accessibilityIdentifier = GenericItemCellIdentifiers.titleLabel.rawValue
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: .regular, size: .medium)
        label.textColor = .neutralDarkGrey
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.accessibilityIdentifier = GenericItemCellIdentifiers.descriptionLabel.rawValue
        return label
    }()
    
    // MARK: - Instantiate
    
    static func instantiate() -> GenericItemCell? {
        let view = GenericItemCell()
        return view
    }
    
    // MARK: - Public Methods
    
    func setup(viewModel: GenericItemCellViewModelProtocol) {
        self.viewModel = viewModel
        bindElements()
        setupLayout()
    }
    
    // MARK: - Private Methods
    
    private func bindElements() {
        viewModel?.title.bind { [weak self] text in
            guard let self = self else { return }
            self.titleLabel.text = text
        }
        
        viewModel?.description.bind { [weak self] text in
            guard let self = self else { return }
            self.descriptionLabel.text = text
        }
    }
    
    private func setupLayout() {
        backgroundColor = .neutralWhite
        setupTitleLabelLayout()
        setupDescriptioLabelLayout()
    }
    
    private func setupTitleLabelLayout() {
        addSubview(titleLabel)
        titleLabel.anchor(top: safeTopAnchor,
                          paddingTop: .spacing(.medium))
        titleLabel.anchor(left: safeLeftAnchor,
                          right: safeRightAnchor,
                          paddingLeft: .spacing(.medium),
                          paddingRight: .spacing(.medium))
    }
    
    private func setupDescriptioLabelLayout() {
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: titleLabel.safeBottomAnchor,
                                bottom: safeBottomAnchor,
                                paddingTop: .spacing(.extraSmall),
                                paddingBottom: .spacing(.medium))
        descriptionLabel.anchor(left: titleLabel.safeLeftAnchor,
                                right: titleLabel.safeRightAnchor)
    }
}
