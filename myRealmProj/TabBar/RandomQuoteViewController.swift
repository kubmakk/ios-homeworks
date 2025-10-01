//
//  RandomQuoteViewController.swift
//  myRealmProj
//
//  Created by kubmakk on 1/10/25.
//

import UIKit
import RealmSwift

class RandomQuoteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        let loadButton = UIButton(type: .system)
        loadButton.setTitle("Загрузить", for: .normal)
        loadButton.addTarget(self, action: #selector(loadQuote), for: .touchUpInside)

        loadButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadButton)

        NSLayoutConstraint.activate([
            loadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func loadQuote() {

        NetworkManager.shared.fetchQuote { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let quoteData):
                    self?.saveQuote(quoteData)
                case .failure(let error):
                    print("Ошибка загрузки: \(error.localizedDescription)")
                }
            }
        }
    }

    private func saveQuote(_ quoteData: QuoteData) {
        do {
            let realm = try Realm()
            try realm.write {
                let quote = Quote()
                quote.id = quoteData.id
                quote.value = quoteData.value
                quote.date = Date()

                for categoryName in quoteData.categories {

                    if let existingCategory = realm.object(ofType: Category.self, forPrimaryKey: categoryName) {
                        quote.categories.append(existingCategory)
                    } else {
                        let newCategory = Category()
                        newCategory.name = categoryName
                        quote.categories.append(newCategory)
                    }
                }
                

                realm.add(quote, update: .modified)
            }
            showAlert(title: "Успех", message: "Цитата сохранена!")
        } catch {
            showAlert(title: "Ошибка", message: "Не удалось сохранить цитату: \(error.localizedDescription)")
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
