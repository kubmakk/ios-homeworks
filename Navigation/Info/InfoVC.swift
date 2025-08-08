//
//  InfoViewController.swift
//  Navigation
//

import UIKit
import SnapKit

final class InfoViewController: UIViewController {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Загрузка"
        return label
    }()
    
    private lazy var alertButton: CustomButton = {
        let button = CustomButton(
            title: "Alert",
            titleColor: .white,
            backroundColor: .systemPink,
            radius: LayoutConstants.cornerRadius,
            autoresizing: false,
            target: self,
            selector: #selector(tapAlertButton)
        )
        return button
    }()
    //MARK: - LiveCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        view.addSubview(titleLabel)
        view.addSubview(alertButton)
        setupConstraints()
        fetchData()
    }
//MARK: - Functioins
    private func setupConstraints() {
        // Констрейнты для кнопки (в центре)
        NSLayoutConstraint.activate([
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertButton.heightAnchor.constraint(equalToConstant: 50),
            alertButton.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        // Констрейнты для лейбла (над кнопкой)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // Привязываем низ лейбла к верху кнопки с отступом в 20 поинтов
            titleLabel.bottomAnchor.constraint(equalTo: alertButton.topAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func fetchData() {
           guard let userinfo = URL(string: "https://jsonplaceholder.typicode.com/todos/2") else {
               print("Неверный URL")
               return
           }

           let task = URLSession.shared.dataTask(with: userinfo) { data, response, error in
               if let error = error {
                   print("Ошибка при выполнении запроса: \(error.localizedDescription)")
                   return
               }

               guard let jsonData = data else {
                   print("Данные не были получены")
                   return
               }

               do {
                   if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                       
                       if let title = jsonObject["title"] as? String {
                           
                           DispatchQueue.main.async {
                               self.titleLabel.text = title
                           }
                       }
                   }
               } catch {
                   print("Ошибка при парсинге JSON: \(error.localizedDescription)")
               }
           }

           task.resume()
       }
    
    @objc func tapAlertButton() {
        let alert = UIAlertController(title: "Attention",
                                      message: "How are you feeling?",
                                      preferredStyle: .alert)
        // add two buttons
        let fine = UIAlertAction(title: "Fine", style: .default) { _ in
            print("Fine")
        }
        alert.addAction(fine)
        
        let so = UIAlertAction(title: "So-so", style: .destructive) { _ in
            print("So-so")
        }
        alert.addAction(so)

        self.present(alert, animated: true, completion: nil)
    }
}
