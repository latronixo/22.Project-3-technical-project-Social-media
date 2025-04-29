//
//  ViewController.swift
//  16. Setting up (UIKit)
//
//  Created by Валентин Картошкин on 19.04.2025.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //создаем константу - файловый менеджер
        let fm = FileManager.default
        //создаем константу - путь к ресурсам нашего приложения
        let path = Bundle.main.resourcePath!
        //записываем в константу содержимое папки с ресурсами нашего приложения (скомпилированного)
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        //перебирая ресурсы приложения, будем работать только с теми, которые начинаютс c "nssl"
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort()
    }

    //событие нажатие на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.pictureId = indexPath.row
            vc.countOfPictures = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //задаем количество строк (ячеек)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    //описываем создание каждой ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }

}

