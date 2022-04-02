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

    }
}
extension ProfileViewController: UITableViewDataSource {
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell") as! PostTableViewCell
        cell.authorLabel.text = self.posts[indexPath.row].author
        cell.postImageView.image = UIImage(named: self.posts[indexPath.row].image)
        cell.postTextView.text = self.posts[indexPath.row].description
        cell.likesLabel.text = "Likes: " + ("\(self.posts[indexPath.row].likes)")
        cell.viewsLabel.text = "Views: " + ("\(self.posts[indexPath.row].views)")
        return cell
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header")
        return header
    }
}
