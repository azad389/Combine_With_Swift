//
//  ViewController.swift
//  Demo_Combine
//
//  Created by Azad Rather on 03/05/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet weak var tableVw: UITableView!
    private var cancellables = Set<AnyCancellable>()
    @Published var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVw.dataSource = self
        tableVw.delegate = self
        tableVw.estimatedRowHeight = 100
        tableVw.rowHeight = UITableView.automaticDimension
        viewModel.getPosts1()
            .sink { _ in
            } receiveValue: { [weak self] posts in
                print(posts.count)
                print(posts.first?.body)
                self?.viewModel.details = posts
                self?.tableVw.reloadData()
            }
            .store(in: &cancellables)
    }
}


extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.details?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableCell", for: indexPath) as? DetailTableCell else{return UITableViewCell()}
        cell.id.text = "Id: " + "\(viewModel.details?[indexPath.row].id ?? 0)"
        cell.userId.text = "Use Id: " + "\(viewModel.details?[indexPath.row].userId ?? 0)"
        cell.tittle.text = "Tittle: " + (viewModel.details?[indexPath.row].title ?? "")
        cell.body.text = "Subtittle: " + (viewModel.details?[indexPath.row].body ?? "")
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Combine Example"
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
    
}

class DetailTableCell:UITableViewCell{
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var tittle: UILabel!
    @IBOutlet weak var body: UILabel!
}
