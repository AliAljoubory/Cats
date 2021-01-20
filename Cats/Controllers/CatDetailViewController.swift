//
//  CatDetailViewController.swift
//  Cats
//
//  Created by Ali Aljoubory on 28/12/2020.
//

import UIKit

class CatDetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameResponseLabel: UILabel!
    @IBOutlet var temperamentResponseLabel: UILabel!
    @IBOutlet var energyLevelResponseLabel: UILabel!
    @IBOutlet var wikipediaUrlButton: UIButton!
    
    var name: String?
    var imageUrl: String?
    var temperament: String?
    var energyLevel: String?
    var wikipediaURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDoneButton()
        setUpButton()
        setUpUI()
    }
    
    func addDoneButton() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVc))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func setUpButton() {
        wikipediaUrlButton.layer.cornerRadius = 10
        wikipediaUrlButton.setTitle("\(name ?? "") Wikipedia page", for: .normal)
    }
    
    func setUpUI() {
        NetworkManager.shared.downloadImage(from: imageUrl ?? "") { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.imageView.image = image }
        }
        
        nameResponseLabel.text = name
        temperamentResponseLabel.text = temperament
        energyLevelResponseLabel.text = energyLevel
    }
    
    @objc func dismissVc() {
        dismiss(animated: true)
    }
    
    @IBAction func wikipediaUrlButtonPressed(_ sender: UIButton) {
        guard let url = URL(string: wikipediaURL ?? "") else {
            presentAlert(title: "Invalid URL", message: "The Wikipedia URL for \(name ?? "") is invalid", actionTitle: "OK", actionStyle: .default)
            return
        }
        
        presentSafariVC(with: url)
    }
}
