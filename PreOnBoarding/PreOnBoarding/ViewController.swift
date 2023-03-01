//
//  ViewController.swift
//  PreOnBoarding
//
//  Created by sejin jeong on 2023/03/02.
//

import UIKit

class ViewController: UIViewController{

    let imageUrls = ["https://img.freepik.com/premium-vector/cute-lion-character-design-illustration_493925-777.jpg?w=900", "https://img.freepik.com/free-vector/coloured-tiger-design_1196-140.jpg?w=900&t=st=1677699555~exp=1677700155~hmac=871b5a625770ae803e4d173f5fb47f876c387de1cc5619034507b34cdad80635", "https://cdn-icons-png.flaticon.com/512/952/952398.png?w=900&t=st=1677699616~exp=1677700216~hmac=7092dcb95119381c3bacb8249afb3c2878e3cbfe4a03971e47a3381bef7cbde9","https://cdn-icons-png.flaticon.com/512/406/406249.png?w=900&t=st=1677699647~exp=1677700247~hmac=6ee48d5fb4d2f0575f964e4e8bc96e4a40f3765fb8c9f57546465f13715e061a", "https://cdn-icons-png.flaticon.com/512/884/884078.png?w=900&t=st=1677699666~exp=1677700266~hmac=96cc216f4d4a5c3799e711315a4ac9fcf52d797b303dff349b58d16ad70a9ba8"]
    
    let allImageButton : UIButton = {
        let button = UIButton()
        button.setTitle("Load All Images", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAutolayout()
    }
    
    func setAutolayout(){
        view.addSubview(tableView)
        view.addSubview(allImageButton)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        allImageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            
            allImageButton.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            allImageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            allImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @IBAction func buttonTapped(_ sender: Any) {
        tableView.visibleCells.forEach { cell in
            (cell as? CustomTableViewCell)?.loadButton.sendActions(for: .touchUpInside)
        }
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell
        else { return UITableViewCell()}
        cell.setButtonAction {
            cell.thumbnailImageView.image = UIImage(systemName: "photo")
            guard let imageUrl = URL(string: self.imageUrls[indexPath.row]) else {return}
            let task = URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
                    if let error = error {
                        print("Error downloading image: \(error.localizedDescription)")
                        return
                    }
                    guard let data = data, let image = UIImage(data: data) else {
                        print("Error creating image from data")
                        return
                    }
                    DispatchQueue.main.async {
                        cell.thumbnailImageView.image = image
                    }
                }
                task.resume()

        }
        return cell
    }
    
    
}

