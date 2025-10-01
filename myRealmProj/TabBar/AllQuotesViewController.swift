//
//  AllQuotesViewController.swift
//  myRealmProj
//
//  Created by kubmakk on 1/10/25.
//

import UIKit
import RealmSwift
import Realm

class AllQuotesViewController: UITableViewController {
    private var quotes: Results<Quote>?
    private var notificationToken: NotificationToken?
    private lazy var realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Все цитаты"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "quoteCell")
        
        quotes = realm.objects(Quote.self).sorted(byKeyPath: "date", ascending: false)
        
        notificationToken = quotes?.observe { [weak self] _ in
            self?.tableView.reloadData()
        }
    }

    deinit {
        notificationToken?.invalidate()
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
