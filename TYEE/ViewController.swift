//
//  HomeScreenViewController.swift
//  TYEE
//
//  Created by Sebastian Ottow on 07.09.22.
//

import UIKit
import TinyConstraints

class ViewController: UIViewController {

    var homeBackgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "homeBackgroundImage.png")
        imageView.alpha = 0.8
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private var _trophyButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        view.addSubview(homeBackgroundView)

        homeBackgroundView.edgesToSuperview()

        view.addSubview(_trophyButton)
        configureButton()
    }

    func configureButton() {
        _trophyButton.configuration = .filled()
        _trophyButton.configuration?.title = "My Trophies"
        _trophyButton.configuration?.baseForegroundColor = .white
        _trophyButton.configuration?.baseBackgroundColor = .systemBlue

        _trophyButton.configuration?.image = UIImage(systemName: "photo.circle")
        _trophyButton.configuration?.imagePadding = 6
        _trophyButton.configuration?.imagePlacement = .leading
        _trophyButton.configuration?.cornerStyle = .capsule

        _trophyButton.configuration?.subtitle = "just a bunch of dandies"

        _trophyButton.isEnabled = true
        _trophyButton.addTarget(self, action: #selector(trophyListButtonTouchUpInside(_:)), for: .touchUpInside)

        addButtonConstraints()
    }

    func addButtonConstraints() {
        homeBackgroundView.addSubview(_trophyButton)
        _trophyButton.translatesAutoresizingMaskIntoConstraints = false

        _trophyButton.centerXToSuperview()
        _trophyButton.topToBottom(of: homeBackgroundView, offset: -120)
    }

    @objc func trophyListButtonTouchUpInside(_ sender: UIButton!) {
        print("Button taped!")

        let trophyListViewController = TrophyListTableViewViewController()

        navigationController?.pushViewController(trophyListViewController, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        _trophyButton.addTarget(self, action: #selector(trophyListButtonTouchUpInside(_:)), for: .touchUpInside)

    }
}

