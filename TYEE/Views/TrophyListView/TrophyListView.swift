//
//  TrophyListView.swift
//  TYEE
//
//  Created by Sebastian Ottow on 12.09.22.
//

import Foundation
import UIKit

class TrophyListTableViewHeaderFooterView: UITableViewHeaderFooterView {

    let title = UILabel()
    let image = UIImageView()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .blue

        title.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(image)
        contentView.addSubview(title)

        NSLayoutConstraint.activate([
            image.leading(to: title),

            title.centerXToSuperview(),
            title.centerYToSuperview()
        ])
    }
}

