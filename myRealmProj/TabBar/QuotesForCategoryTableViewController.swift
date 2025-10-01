//
//  QuotesForCategoryTableViewController.swift
//  myRealmProj
//
//  Created by kubmakk on 1/10/25.
//

import UIKit
import RealmSwift

class QuotesForCategoryViewController: UITableViewController {
    var category: Category?
    private var quotes: Results<Quote>?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = category?.name
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "quoteCell")
        
        if let category = category {
            quotes = category.quotes.sorted(byKeyPath: "date", ascending: false)
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
