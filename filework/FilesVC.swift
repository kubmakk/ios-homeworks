//
//  FilesVC.swift
//  Navigation
//
//  Created by kubmakk on 18/9/25.
//
import UIKit

class FilesViewController: UITableViewController {
    
    var fileURLs: [URL] = []
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Documents"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        loadFiles()
    }

    
    // MARK: - Logic
    private func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    private func loadFiles(){
        do {
            fileURLs = try FileManager.default.contentsOfDirectory(at: getDocumentsDirectory(), includingPropertiesForKeys: nil)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        } catch {
            print("Ошибка загрузки директории: \(error.localizedDescription)")
        }
    }
    

@objc func addButtonTapped() {
        let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    
    imagePicker.sourceType = .photoLibrary
    present(imagePicker, animated: true)
    
    }

}

extension FilesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileURLs.count
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt insexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            let fileToDelete = fileURLs[indexPath.row]
            do {
                try FileManager.default.removeItem(at: fileToDelete)
                print("Файл \(fileToDelete.lastPathComponent) удален")
                fileURLs.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("Не получилось удалить")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let url = fileURLs[indexPath.row]
        
        cell.textLabel?.text = url.lastPathComponent
        cell.imageView?.image = UIImage(systemName: "photo")
        return cell
    }
}

extension FilesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let image = info[.originalImage] as? UIImage else {
            picker.dismiss(animated: true)
            return
        }

        picker.dismiss(animated: true)

        let imageName = UUID().uuidString + ".jpeg"
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {

            do {
                try jpegData.write(to: imagePath)
                print("Файл успешно сохранен по пути: \(imagePath)")

                loadFiles()
            } catch {
                print("Не удалось сохранить изображение: \(error.localizedDescription)")
            }
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
