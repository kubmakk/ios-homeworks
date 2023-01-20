//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Admin on 08.02.2022.
//

import StorageService
import UIKit

class ProfileViewController: UIViewController {
    private let databaseCoordinator: DatabaseCoordinatable
    weak var coordinator: ProfileCoordinator?
    var viewModel: ProfileViewModel!
    let user: User?
    let userServise: UserService
    var headerTable: ProfileTableHeaderView?
    
    let posts:[Post] = [postFirst, postSecond, postThird, postFourth]
    
    private lazy var tap: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.numberOfTapsRequired = 1
        recognizer.addTarget(self, action: #selector(processTap))
        return recognizer
    }()
    let closeButton: CustomButton = {
        let button = CustomButton(title: "X", color: .clear)
        button.titleLabel?.textColor = .white
        return button
    }()
    let imageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 55
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    init (userServise: UserService, name: String, databaseCoordinator: DatabaseCoordinatable){
        self.userServise = userServise
        self.databaseCoordinator = databaseCoordinator
        user = userServise.getName(name: name)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        super.loadView()
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.tableView.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        #if DEBUG
        self.tableView.backgroundColor = .red
        #endif
        navigationController?.navigationBar.isHidden = true

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    func setupTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "idCell")
        self.tableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "Header")
        self.tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "idCell2")
    }
    @objc func processTap() {
        print("TapOkPicture")
        self.view.addSubview(imageView)
        headerTable?.profileHeaderView.avatarImageView.isHidden = true
        self.avatarImageView.image = UIImage(named: user!.avatar)
        self.imageView.addSubview(avatarImageView)
        self.imageView.addSubview(closeButton)
        showStatusButtonPressed()
        self.closeButton.alpha = 0
        NSLayoutConstraint.activate([
            self.avatarImageView.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor),
            self.avatarImageView.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor),
            self.avatarImageView.widthAnchor.constraint(equalTo: self.imageView.safeAreaLayoutGuide.widthAnchor),
            self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor),
            
            self.closeButton.topAnchor.constraint(equalTo: self.avatarImageView.topAnchor),
            self.closeButton.trailingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor)
        ])
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
            self.avatarImageView.layer.cornerRadius = 0
            NSLayoutConstraint.activate([
                self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
                self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
            self.view.layoutIfNeeded()
        } completion: { finished in
            UIView.animate(
                withDuration: 0.3) {
                    self.closeButton.alpha = 1
                    self.imageView.layoutIfNeeded()
                }
        }
    }
    @objc func showStatusButtonPressed() {
        closeButton.tapAction = {
            print(#function)
            UIView.animate(withDuration: 1) {
                self.closeButton.alpha = 0
                self.imageView.layoutIfNeeded()
            } completion: { finished in
                self.closeButton.removeFromSuperview()
                UIView.animate(
                    withDuration: 0.5) {
                        self.avatarImageView.layer.cornerRadius = 55
                        NSLayoutConstraint.activate([
                            self.avatarImageView.centerXAnchor.constraint(equalTo: self.imageView.leadingAnchor, constant: 71),
                            self.avatarImageView.centerYAnchor.constraint(equalTo: self.imageView.topAnchor, constant: 95),
                            self.avatarImageView.widthAnchor.constraint(equalTo: self.imageView.safeAreaLayoutGuide.widthAnchor, constant: -260),
                            self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor),
                        ])
                        self.view.layoutIfNeeded()
                    } completion: { finished in
                        self.avatarImageView.removeFromSuperview()
                        self.imageView.removeFromSuperview()
                        self.headerTable?.profileHeaderView.avatarImageView.isHidden = false
                    }
            }
        }
    }
    func savePostInDatabase(_ filterPost: Post) {
            self.databaseCoordinator.create(PostCoreDataModel.self, keyedValues: [filterPost.keyedValues]) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let post):
                
                let userInfo = ["Post": filterPost]
                NotificationCenter.default.post(name: .wasLikedArticle, object: nil, userInfo: userInfo)
            case .failure(let error):
                print("🍋 \(error)")
            }
        }
    }

}
// MARK: Extension
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
            cell.photoLabel.text = NSLocalizedString("Photos", comment: "Subtitle")
            cell.photoImageView.image = UIImage(named: "1")
            cell.photoImageView1.image = UIImage(named: "2")
            cell.photoImageView2.image = UIImage(named: "3")
            cell.photoImageView3.image = UIImage(named: "4")
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "idCell") as! PostTableViewCell
            cell.authorLabel.text = self.posts[indexPath.row].author
            cell.postImageView.image = UIImage(named: self.posts[indexPath.row].image)
            cell.postTextView.text = self.posts[indexPath.row].descript
            cell.likesLabel.text = NSLocalizedString("Likes: ", comment: "likes post") + ("\(self.posts[indexPath.row].likes)")
            cell.viewsLabel.text = NSLocalizedString("Views: ", comment: "views post") + ("\(self.posts[indexPath.row].views)")
            cell.delegate = self
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
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! ProfileTableHeaderView
            headerTable = header
            headerTable?.profileHeaderView.avatarImageView.addGestureRecognizer(tap)
            headerTable?.profileHeaderView.statusLabel.text = user?.status
            headerTable?.profileHeaderView.fullNameLabel.text = user?.fullName
            headerTable?.profileHeaderView.avatarImageView.image = UIImage(named: user!.avatar)
            return header
        default:
            break
        }
        return nil
    }
}
extension ProfileViewController: PostTableViewCellDelegate {
    func wasLikedPost(authorLabel: UILabel?) {
        print(#function)
        guard let authorLabel = authorLabel else {
            return
        }
        for i in self.posts {
            if i.author == authorLabel.text {
                if let index = posts.firstIndex(of: i) {
                    self.savePostInDatabase(posts[index])
                }
            }
        }
    }
}
