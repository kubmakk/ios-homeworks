
import UIKit

class InfoViewController: UIViewController {
    
    lazy var alerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Alert", for: .normal)
        return button
    }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            title = "Info"
            
            view.addSubview(alerButton)
            
            alerButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
            alerButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                alerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                alerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    @objc func showAlert() {
        let alert = UIAlertController(title: "Сообщение", message: "Описание", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default){_ in
            print("Нажата кнопка OK")
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel){_ in
            print("Нажата кнопка Отмена")}
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    }
