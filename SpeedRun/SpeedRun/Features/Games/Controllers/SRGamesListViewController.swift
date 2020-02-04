//
//  SRGamesListViewController.swift
//  SpeedRun
//
//  Created by Jordi Durán on 30/01/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import UIKit

class SRGamesListViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    
    fileprivate let viewModel = SRGamesListViewModel()
    fileprivate var cellsVM = [SRBaseTableViewCellViewModel]()
    
    
    // MARK: - Live cicle method's
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Configure and register tableView cells
        registerTableViewCells()
        SRBaseTableViewCellViewModel.configureTable(tableView, bounces: true)
        
        // Recover cells
        self.cellsVM = viewModel.getCellsVM()
        
        // Fetch data
        fetchData()
            
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "SpeedRun"
    }
    
    
    // MARK: - Config Methods
    
    func registerTableViewCells() {
        tableView.srRegisterCell(nibName: .gameListCell)
        tableView.srRegisterCell(nibName: .loadingCell)
        tableView.srRegisterCell(nibName: .errorCell)
    }
    
    func fetchData() {
        self.reloadTableView()
        viewModel.fetchGamesList(success: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.reloadTableView()
        }) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.reloadTableView(withError: true)
        }
    }
    
    func reloadTableView(withError error: Bool = false) {
        self.cellsVM = self.viewModel.getCellsVM(withError: error)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}



// MARK: - TableView extension

extension SRGamesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SRBaseTableViewCellViewModel.tableViewCell(forRowAtIndexPath: indexPath, tableView, cellsVM: cellsVM, delegate: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SRBaseTableViewCellViewModel.getCellHeight(cellsVM: cellsVM, index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellVM = SRBaseTableViewCellViewModel.getCellVM(atIndex: indexPath.row, forCellsVM: cellsVM) else { return }
        switch cellVM.cellType {
        case .gameListCell:
            guard let gameModel = cellVM.cellActionIdentifier as? SRGameModel else { return }
            guard let viewController = SRGameDetailViewController.storyboardInstance(selectedGame: gameModel) else { return }
            self.navigationController?.pushViewController(viewController, animated: true)
            
        default:
            break
        }
    }

}



extension SRGamesListViewController: SRErrorTableViewCellProtocol {
    
    func errorButtonPressed(cellActionIdentifier: Any?) {
        viewModel.resetData()
        fetchData()
    }
    
}
