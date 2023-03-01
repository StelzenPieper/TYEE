//
//  TrophyListTableViewCell.swift
//  TYEE
//
//  Created by Sebastian Ottow on 09.09.22.
//

import Foundation
import UIKit
import TinyConstraints

class TrophyListTableViewCell: UITableViewCell {
    static let identifier = "TrophyListTableViewCell"

    var viewModel: Trophy?

    let trophyView = UIView()
    let trophyImageView = UIImageView()
    let trophyCatchStyleIconImageView = UIImageView()
    let trophyLabel = UILabel()
    let trophyWeight = UILabel()
    let trophyLength = UILabel()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // add shadow on cell
        backgroundColor = .clear // very important
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor

        // add corner radius on `contentView`
//        contentView.backgroundColor = .white.withAlphaComponent(0.65)
        contentView.layer.cornerRadius = 5

        addSubview(trophyView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customCell() {
        _configureTrophyView()
    }

    private func _configureTrophyView() {
        trophyView.backgroundColor = .white.withAlphaComponent(0.65)
        trophyView.edgesToSuperview(insets: .init(top: 10, left: 10, bottom: 10, right: 10))
        trophyView.layer.cornerRadius = 5
        trophyView.clipsToBounds = true


        trophyView.addSubview(trophyLabel)
        trophyView.addSubview(trophyImageView)
        trophyView.addSubview(trophyCatchStyleIconImageView)
        trophyView.addSubview(trophyWeight)
        trophyView.addSubview(trophyLength)
        
        _configureTrophyLabel()
        _configureTrophyImageView()
        _configureTrophyCatchStyleIconImageView()
        _configureTrophyWeight()
        _configureTrophyLength()
    }

    private func _configureTrophyImageView() {
        trophyImageView.clipsToBounds = true
        trophyImageView.image = UIImage(named: "Trout_horizontal_Image")

        _setTrophyImageConstraints()
        _setTrophyLabelConstraints()
        _setTrophyCatchStyleIconImageView()
        _setTrophyWeigthConstraints()
        _setTrophyLengthConstraints()
    }

    private func _configureTrophyCatchStyleIconImageView() {
        trophyCatchStyleIconImageView.image = UIImage(systemName: "photo.circle")?.withTintColor(.blue)
    }

    private func _configureTrophyLabel() {
        trophyLabel.numberOfLines = 0
        trophyLabel.adjustsFontSizeToFitWidth = true
        trophyLabel.text = viewModel?.trophySpecies
    }

    private func _configureTrophyWeight() {
        trophyWeight.numberOfLines = 0
        trophyWeight.adjustsFontSizeToFitWidth = true
        trophyWeight.text = "\(viewModel?.trophyWeight.description ?? "0")g"
    }

    private func _configureTrophyLength() {
        trophyLength.numberOfLines = 0
        trophyLength.adjustsFontSizeToFitWidth = true
        trophyLength.text = "\(viewModel?.trophyLength.description ?? "0") cm"
    }

    private func _setTrophyImageConstraints() {
        trophyImageView.translatesAutoresizingMaskIntoConstraints = false
        trophyImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        trophyImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        trophyImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        trophyImageView.widthAnchor.constraint(equalTo: trophyImageView.heightAnchor, multiplier: 16/9).isActive = true
    }

    private func _setTrophyLabelConstraints() {
        trophyLabel.translatesAutoresizingMaskIntoConstraints = false
        trophyLabel.topAnchor.constraint(equalTo: trophyView.topAnchor, constant: 8).isActive = true
        trophyLabel.leadingAnchor.constraint(equalTo: trophyImageView.trailingAnchor, constant: 8).isActive = true
    }

    private func _setTrophyWeigthConstraints() {
        trophyWeight.translatesAutoresizingMaskIntoConstraints = false
        trophyWeight.topAnchor.constraint(equalTo: trophyLabel.bottomAnchor, constant: 3).isActive = true
        trophyWeight.leadingAnchor.constraint(equalTo: trophyImageView.trailingAnchor, constant: 8).isActive = true
    }

    private func _setTrophyLengthConstraints() {
        trophyLength.translatesAutoresizingMaskIntoConstraints = false
        trophyLength.topAnchor.constraint(equalTo: trophyWeight.bottomAnchor, constant: 3).isActive = true
        trophyLength.leadingAnchor.constraint(equalTo: trophyImageView.trailingAnchor, constant: 8).isActive = true
    }

    private func _setTrophyCatchStyleIconImageView() {
        trophyCatchStyleIconImageView.translatesAutoresizingMaskIntoConstraints = false
        trophyCatchStyleIconImageView.topAnchor.constraint(equalTo: trophyView.topAnchor, constant: 8).isActive = true
        trophyCatchStyleIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
}
