//
//  CategoriesViewController.swift
//  myRealmProj
//
//  Created by kubmakk on 1/10/25.
//

import UIKit
import RealmSwift
import Realm

class CategoriesViewController: UITableViewController {
    private var categories: Results<Category>?
    private let realm = try! Realm()
    private var notificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Категории"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "categoryCell")
        
        categories = realm.objects(Category.self).sorted(byKeyPath: "name")

        notificationToken = categories?.observe { [weak self] _ in
            self?.tableView.reloadData()
        }

        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshCategories), for: .valueChanged)
        refreshControl = refresh

        loadCategories()
    }

    deinit {
        notificationToken?.invalidate()
    }

    @objc private func refreshCategories() {
        loadCategories()
    }

    private func loadCategories() {
        NetworkManager.shared.fetchCategories { [weak self] result in
            DispatchQueue.main.async {
                self?.refreshControl?.endRefreshing()
                switch result {
                case .success(let names):
                    guard let self = self else { return }
                    do {
                        let realm = try Realm()
                        try realm.write {
                            for name in names {
                                let category = Category()
                                category.name = name
                                realm.add(category, update: .modified)
                            }
                        }
                    } catch {
                        print("Realm write error: \(error)")
                    }
                case .failure(let error):
                    print("Failed to fetch categories: \(error.localizedDescription)")
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = categories?[indexPath.row] else { return }
        
        let quotesForCategoryVC = QuotesForCategoryViewController()
        quotesForCategoryVC.category = category
        navigationController?.pushViewController(quotesForCategoryVC, animated: true)
    }
}
