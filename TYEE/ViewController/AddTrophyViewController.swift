//
//  AddTrophyViewController.swift
//  TYEE
//
//  Created by Sebastian Ottow on 04.10.22.
//

import Foundation
import UIKit

class AddTrophyViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
        
    let addTrophyView = UIView()
    let cancelButton = UIButton()
    let newTrophyFishSpeciesTextField = UITextField()

    private var _viewModel: TrophyListViewModel?
    private let _addNewTrophyButton = UIButton()
    private let _addTrophyImageButton = UIButton()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }

        dismiss(animated: true)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func setupAddTrophyImageButton() {
        addTrophyView.addSubview(_addTrophyImageButton)
        
        _addTrophyImageButton.configuration = .filled()
        _addTrophyImageButton.configuration?.baseBackgroundColor = .systemBlue
        _addTrophyImageButton.configuration?.title = "Add Image"
        
        _addTrophyImageButton.addTarget(self, action: #selector(addNewTrophyImageButtonTouchUpInside(_:)), for: .touchUpInside)
        
        _addTrophyImageButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            _addTrophyImageButton.centerXAnchor.constraint(equalTo: addTrophyView.centerXAnchor),
            _addTrophyImageButton.top(to: addTrophyView, offset: 10)
        ])
    }

    private func setupAddNewTrophyButton() {
        addTrophyView.addSubview(_addNewTrophyButton)

        _addNewTrophyButton.configuration = .filled()
        _addNewTrophyButton.configuration?.baseBackgroundColor = .systemPink
        _addNewTrophyButton.configuration?.title = "Add Trophy"

        _addNewTrophyButton.addTarget(self, action: #selector(addNewTrophyButtonTouchUpInside(_:)), for: .touchUpInside)

        _addNewTrophyButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            _addNewTrophyButton.centerXAnchor.constraint(equalTo: addTrophyView.centerXAnchor),
            _addNewTrophyButton.bottom(to: addTrophyView, offset: -10)
        ])
    }

    private func setupCancelButton() {
        addTrophyView.addSubview(cancelButton)

        cancelButton.configuration = .filled()
        cancelButton.configuration?.baseBackgroundColor = .systemRed
        cancelButton.configuration?.image = UIImage(systemName: "xmark")
        cancelButton.configuration?.cornerStyle = .capsule

        cancelButton.addTarget(self, action: #selector(cancelButtonTouchUpInside(_:)), for: .touchUpInside)

        cancelButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cancelButton.top(to: addTrophyView, offset: 10),
            cancelButton.trailing(to: addTrophyView, offset: -10)
        ])
    }

    private func setupNewTrophyFishSpeciesTextField() {
        addTrophyView.addSubview(newTrophyFishSpeciesTextField)

        newTrophyFishSpeciesTextField.translatesAutoresizingMaskIntoConstraints = false
        newTrophyFishSpeciesTextField.backgroundColor = .red


        NSLayoutConstraint.activate([
            newTrophyFishSpeciesTextField.centerXAnchor.constraint(equalTo: addTrophyView.centerXAnchor),
            newTrophyFishSpeciesTextField.bottom(to: addTrophyView, offset: -200),
            newTrophyFishSpeciesTextField.leftAnchor.constraint(equalTo: addTrophyView.leftAnchor, constant: 10),
            newTrophyFishSpeciesTextField.rightAnchor.constraint(equalTo: addTrophyView.rightAnchor, constant: -10),        ])
    }

    private func setupAddTrophyView() {
        view.addSubview(addTrophyView)

        addTrophyView.translatesAutoresizingMaskIntoConstraints = false
        addTrophyView.backgroundColor = .white.withAlphaComponent(0.95)
        addTrophyView.layer.cornerRadius = 20

        NSLayoutConstraint.activate([
            addTrophyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            addTrophyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            addTrophyView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            addTrophyView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
        ])

        setupAddNewTrophyButton()
        setupCancelButton()
        setupNewTrophyFishSpeciesTextField()
        setupAddTrophyImageButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 20

        setupAddTrophyView()

        _viewModel = TrophyListViewModel(model: nil)
    }
    
    @objc func addNewTrophyImageButtonTouchUpInside(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    @objc func cancelButtonTouchUpInside(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func addNewTrophyButtonTouchUpInside(_ sender: UIButton) {
        if let newTrophyFishSpecies = newTrophyFishSpeciesTextField.text, !newTrophyFishSpecies.isEmpty {

            _viewModel?.addNewTrophy(newFishSpecies: newTrophyFishSpecies, newFishLength: 12.12, newFishWeight: 12.12, newTrophyImage: newTrophyFishSpecies, newTrophyCatchStyle: newTrophyFishSpecies)
        }
        
        self.dismiss(animated: true)
    }
}
