//
//  ProfileTableHeaderView.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 02.04.2022.
//

import UIKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {

    let profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(profileHeaderView)
        NSLayoutConstraint.activate([
            self.profileHeaderView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.profileHeaderView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.profileHeaderView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
