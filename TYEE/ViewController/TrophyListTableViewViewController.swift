//
//  TrophyListViewController.swift
//  TYEE
//
//  Created by Sebastian Ottow on 07.09.22.
//

import Foundation
import UIKit
import TPKeyboardAvoiding


class TrophyListTableViewViewController: UITableViewController {

    var trophyListTableView: UITableView? {
        let trophyListTableView = UITableView()
        trophyListTableView.translatesAutoresizingMaskIntoConstraints = false
        trophyListTableView.register(
            TrophyListTableViewCell.self,
            forCellReuseIdentifier: "TrophyListTableViewCell"
        )

        return trophyListTableView
    }

    private var _addTrophyButton = UIButton()

    private var trophyListView = TrophyListTableViewHeaderFooterView()

    private var _viewModel: TrophyListViewModel?

    func updateTrophyList() {
        guard let trophies = _viewModel else { return }

        self.tableView?.reloadData()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(
            TrophyListTableViewCell.self,
            forCellReuseIdentifier: "TrophyListTableViewCell"
        )

        tableView.register(
            TrophyListTableViewHeaderFooterView.self,
            forHeaderFooterViewReuseIdentifier: "TrophyListTableViewHeaderFooterView"
        )

        tableView.backgroundView = UIImageView(image: UIImage(named: "LakeBackground.jpg"))

        _viewModel = TrophyListViewModel(model: nil)
        
        _viewModel?.delegate = self

        view.addSubview(_addTrophyButton)
        _configureAddTrophyButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _viewModel?.loadTrophies()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Trophies Header"
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String {
        return "MyTrophies Footer"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _viewModel?.trophies.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrophyListTableViewCell",for: indexPath) as? TrophyListTableViewCell else { return UITableViewCell() }

        let trophy = _viewModel?.trophies[indexPath.row]

        cell.viewModel = trophy
        cell.customCell()

        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        cell.backgroundColor = .clear

        // if you do not set `shadowPath` you'll notice laggy scrolling
        // add this in `willDisplay` method
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }

    private func _configureAddTrophyButton() {
        _addTrophyButton.configuration = .filled()
        _addTrophyButton.configuration?.buttonSize = .large
        _addTrophyButton.configuration?.baseForegroundColor = .white
        _addTrophyButton.configuration?.baseBackgroundColor = .systemBlue

        _addTrophyButton.configuration?.image = UIImage(systemName: "plus")
        _addTrophyButton.configuration?.cornerStyle = .capsule

        _addTrophyButton.isEnabled = true

        _addTrophyButton.addTarget(self, action: #selector(addTrophyButtonTouchUpInside(_:)), for: .touchUpInside)
        
        addTrophyButtonConstraints()
    }

    func addTrophyButtonConstraints() {
        view.addSubview(_addTrophyButton)
        _addTrophyButton.translatesAutoresizingMaskIntoConstraints = false

        _addTrophyButton.centerXToSuperview()
        _addTrophyButton.bottomToTop(of: view, offset: 700)
    }

    @objc func addTrophyButtonTouchUpInside(_ sender: Any) {
        let addTrophyView = AddTrophyViewController()

        addTrophyView.modalPresentationStyle = .fullScreen
        addTrophyView.modalTransitionStyle = .crossDissolve
        navigationController?.present(addTrophyView, animated: false)
    }
}

extension TrophyListTableViewViewController: TrophyListViewModelDelegate {
    func didUpdateTrophies() {
        DispatchQueue.main.async {
            self.updateTrophyList()
        }
    }
}
