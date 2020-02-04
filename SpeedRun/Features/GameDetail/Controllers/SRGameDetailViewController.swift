//
//  SRGameDetailViewController.swift
//  SpeedRun
//
//  Created by Jordi Durán on 02/02/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import UIKit

class SRGameDetailViewController: UIViewController {

    // MARK: - Storyboard Instance
    
    public static func storyboardInstance(selectedGame gameModel: SRGameModel?) -> SRGameDetailViewController? {
        guard let viewController = self.srStoryboardInstance(storyboardIdentifier: "SRGameDetailStoryboard") as? SRGameDetailViewController else { return nil }
        viewController.viewModel.setGameModel(gameModel: gameModel)
        return viewController
    }
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    
    fileprivate let viewModel = SRGameDetailViewModel()
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
        self.title = viewModel.getGameTitle()
    }
    
    
    // MARK: - Config Methods
    
    func registerTableViewCells() {
        tableView.srRegisterCell(nibName: .titleDescriptionCell)
        tableView.srRegisterCell(nibName: .loadingCell)
        tableView.srRegisterCell(nibName: .errorCell)
        tableView.srRegisterCell(nibName: .buttonCell)
        tableView.srRegisterCell(nibName: .imageWithTitleCell)
    }
    
    func fetchData() {
        self.reloadTableView()
        viewModel.fetchGameDetail(success: { [weak self] in
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

extension SRGameDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SRBaseTableViewCellViewModel.tableViewCell(forRowAtIndexPath: indexPath, tableView, cellsVM: cellsVM, delegate: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SRBaseTableViewCellViewModel.getCellHeight(cellsVM: cellsVM, index: indexPath.row)
    }

}



extension SRGameDetailViewController: SRButtonTableViewCellProtocol {
    
    func simpleButtonPressed(cellActionIdentifier: Any?) {
        guard let videoURL = cellActionIdentifier as? URL else { return }
        openURL(url: videoURL)
    }
    
    private func openURL(url: URL) {
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
        }
            
        presentActivityViewController(activityViewController, animated: true, completion: nil)
    }
    
}



// MARK: - Share activity functions

private var originalWindow: UIWindow?
private var activityWindow: UIWindow?

extension SRGameDetailViewController {
    
    fileprivate var isActivityViewControllerPresented: Bool {
        return activityWindow?.isKeyWindow ?? false
    }
    
    func presentActivityViewController(_ activityViewController: UIActivityViewController, animated: Bool = true, completion presentCompletion: (() -> Void)? = nil, activityCompletion: (() -> Void)? = nil) {
        if isActivityViewControllerPresented {
            return
        }
        
        let window = UIWindow(frame: view.window!.frame)
        originalWindow = UIApplication.shared.keyWindow
        activityWindow = window
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()
        
        let activityCompletionClosure = activityViewController.completionWithItemsHandler
        activityViewController.completionWithItemsHandler = { [weak self] (activityType, completed, returnedItems, activityError) in
            self?.restoreWindowFromActivityViewController()
            activityCompletionClosure?(activityType, completed, returnedItems, activityError)
            activityCompletion?()
        }
        
        window.rootViewController?.present(activityViewController, animated: animated, completion: presentCompletion)
    }
    
    fileprivate func restoreWindowFromActivityViewController() {
        originalWindow?.makeKeyAndVisible()
        activityWindow?.rootViewController = nil
        activityWindow = nil
    }
    
}



extension SRGameDetailViewController: SRErrorTableViewCellProtocol {
    
    func errorButtonPressed(cellActionIdentifier: Any?) {
        viewModel.resetData()
        fetchData()
    }
    
}
