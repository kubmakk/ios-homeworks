//
//  QuotesForCategoryTableViewController.swift
//  myRealmProj
//
//  Created by kubmakk on 1/10/25.
//

import UIKit
import RealmSwift
import Realm

class QuotesForCategoryViewController: UITableViewController {
    var category: Category?
    private var quotes: Results<Quote>?
    private var notificationToken: NotificationToken?
    private lazy var realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = category?.name
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "quoteCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Загрузить", style: .plain, target: self, action: #selector(loadQuote))
        
        if let category = category {
            quotes = category.quotes.sorted(byKeyPath: "date", ascending: false)
            notificationToken = quotes?.observe { [weak self] _ in
                self?.tableView.reloadData()
            }
        }
    }

    deinit {
        notificationToken?.invalidate()
    }

    @objc private func loadQuote() {
        guard let name = category?.name else { return }
        NetworkManager.shared.fetchQuote(forCategory: name) { [weak self] result in
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
        } catch {
            print("Не удалось сохранить цитату: \(error.localizedDescription)")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = quotes?[indexPath.row].value
        return cell
    }
}




