//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Admin on 08.02.2022.
//


import UIKit

class ProfileViewController: UIViewController {

    let posts:[Post] = [postFirst, postSecond, postThird, postFourth]
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    func addTableView(){
        self.view.addSubview(tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "idCell")
        self.tableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "Header")
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        self.view.backgroundColor = .lightGray
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        print("viewWillAppear")
    }
}
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return self.posts.count
        default:
            break
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "idCell2") as! PhotosTableViewCell
            cell.photoLabel.text = "Photos"
            cell.photoImageView.image = UIImage(named: "1")
            cell.photoImageView1.image = UIImage(named: "2")
            cell.photoImageView2.image = UIImage(named: "3")
            cell.photoImageView3.image = UIImage(named: "4")
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "idCell") as! PostTableViewCell
            cell.authorLabel.text = self.posts[indexPath.row].author
            cell.postImageView.image = UIImage(named: self.posts[indexPath.row].image)
            cell.postTextView.text = self.posts[indexPath.row].description
            cell.likesLabel.text = "Likes: " + ("\(self.posts[indexPath.row].likes)")
            cell.viewsLabel.text = "Views: " + ("\(self.posts[indexPath.row].views)")
            return cell
        default :
            break
        }
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 220
        default:
            break
        }
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let vc = PhotosViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            print("\(indexPath.section)\(indexPath.row)")
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header")
            return header
        default:
            break
        }
    return nil
    }
}
