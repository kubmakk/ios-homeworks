//
//  SettingsVC.swift
//  filework
//
//  Created by kubmakk on 27/9/25.
//

import Foundation
import UIKit

struct SettingsKeys{
    static let sortAscending: String = "sortAscending"
}

extension Notification.Name{
    static let settingsChanged: Notification.Name = .init("settingsChanged")
}



class SettingsViewController: UITableViewController{
    private var isSortAscending: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "settingsCell")
        
        isSortAscending = UserDefaults.standard.bool(forKey: SettingsKeys.sortAscending)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Sorting"
        } else{
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "settingCell")
        
        if indexPath.section == 0{
            cell.textLabel?.text = "По алфавиту"
            let switchView = UISwitch()
            switchView.isOn = isSortAscending
            switchView.addTarget(self, action: #selector(sortSwitchChanged(_:)), for: .valueChanged)
            cell.accessoryType = .none
            cell.accessoryView = switchView
        } else {
            cell.textLabel?.text = "Поменять пароль"
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    //MARK: - UITableDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            tableView.deselectRow(at: indexPath, animated: true)
            changePass()
        }
    }
    
    private func changePass(){
        let loginVC = LoginViewController()
        loginVC.forceCreateMode = true
        loginVC.success = { [weak self, weak loginVC] in
            try? PasswordManager.shared.deletePassword()
            let alert = UIAlertController(title: "Пароль изменен", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.present(alert, animated: true)
        }
        present(UINavigationController(rootViewController: loginVC), animated: true)

    }
    
    @objc func sortSwitchChanged(_ sender: UISwitch){
        UserDefaults.standard.set(sender.isOn, forKey: SettingsKeys.sortAscending)
        
        NotificationCenter.default.post(name: .settingsChanged, object: nil)
    }
}
    

