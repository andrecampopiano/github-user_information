//
//  GenericCell.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import UIKit

enum GenericCellIdentifiers: String {
    case avatarView = "genericCell_avatarView_id"
    case titleLabel = "genericCell_titleLabel_id"
    case subtitleLabel = "genericCell_subtitleLabel_id"
}

class GenericCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let imageNameDefault: String = "image_default"
        static let imageViewSize: CGFloat = 70
        static let avatarViewBoderWidth: CGFloat = 2
    }
    
    // MARK: - Properties
    
    private var viewModel: GenericCellViewModelProtocol?
    
    private lazy var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.cornerRadius = Constants.imageViewSize / 2
        imageView.borderColor = .black
        imageView.borderWidth = Constants.avatarViewBoderWidth
        imageView.accessibilityIdentifier = GenericCellIdentifiers.avatarView.rawValue
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.accessibilityIdentifier = GenericCellIdentifiers.titleLabel.rawValue
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.accessibilityIdentifier = GenericCellIdentifiers.subtitleLabel.rawValue
        return label
    }()
    
    // MARK: - Instantiate
    
    static func instantiate() -> GenericCell {
        let view = GenericCell()
        return view
    }
    
    // MARK: - Public Methods
    
    func setup(viewModel: GenericCellViewModelProtocol) {
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
        
        viewModel?.subtitle.bind { [weak self] text in
            guard let self = self else { return }
            self.subtitleLabel.text = text
        }
        
        viewModel?.imageUrl.bind { [weak self] imageUrl in
            guard let self = self else { return }
            if let imageUrl = imageUrl, !imageUrl.isEmpty {
                self.avatarView.downloaded(from: imageUrl)
                return
            }
            self.avatarView.image = UIImage(named: Constants.imageNameDefault)
        }
    }
    
    private func setupLayout() {
        backgroundColor = .white
        setupImageViewLayout()
        setupTitleLabel()
        setupSubtitleLabel()
    }
    
    private func setupImageViewLayout() {
        addSubview(avatarView)
        avatarView.anchor(width: Constants.imageViewSize,
                          height: Constants.imageViewSize)
        avatarView.anchor(left: safeLeftAnchor,
                          paddingLeft: .spacing(.small))
        avatarView.anchor(top: safeTopAnchor,
                          bottom: safeBottomAnchor,
                          paddingTop: .spacing(.small),
                          paddingBottom: .spacing(.small))
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.anchor(top: avatarView.safeTopAnchor)
        titleLabel.anchor(left: avatarView.safeRightAnchor,
                          right: safeRightAnchor,
                          paddingLeft: .spacing(.small),
                          paddingRight: .spacing(.small))
    }
    
    private func setupSubtitleLabel() {
        addSubview(subtitleLabel)
        subtitleLabel.anchor(top: titleLabel.safeBottomAnchor,
                             paddingTop: .spacing(.nano))
        subtitleLabel.anchor(left: avatarView.safeRightAnchor,
                             right: safeRightAnchor,
                             paddingLeft: .spacing(.small),
                             paddingRight: .spacing(.small))
    }
}
