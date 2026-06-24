//
//  ProductListViewController.swift
//  TableView_Demo_UIkit
//
//  Created by Abhishek Bagela on 19/06/26.
//

import UIKit

class ProductListViewController: UIViewController {
    
    struct Cells {
        static let productListCell = "ProductListCell"
    }
    
    private let viewModel: ProductListViewModel
    init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController - \(#function) called")
        view.backgroundColor = .white
        title = "Products"
        
        Task {
            try await viewModel.fetchAllProducts()
            tableView.setNeedsLayout()
            
            configureTableView()
        }
    }
    
    var tableView = UITableView()
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        // Set delegate of datasource and table view
        setTableViewDelegate()
        
        // set row height
        setTableViewRowHeight()
        
        // Set constraints
        setTableViewConstraints()
        
        // register cells
        registerTableViewCells()
    }
    
    private func setTableViewDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints                         = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive            = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive    = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive  = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive      = true
    }
    
    private func registerTableViewCells() {
        tableView.register(ProductListCell.self, forCellReuseIdentifier: Cells.productListCell)
    }
    
    private func setTableViewRowHeight() {
        tableView.rowHeight = 100 //TODO: It should be dynamic
    }
    
    private func downloadProductImage(_ url: String) async throws -> UIImage? {
        guard let data = try await viewModel.getProductImage(url) else { return nil }
        return UIImage(data: data)
    }
    
}


//MARK: - TableViewDataSource
extension ProductListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.productListCell) as! ProductListCell
        let product = viewModel.productList[indexPath.row]
        cell.productId = product.id
        
        cell.setCellData(product: product, image: nil)
        
        // Get the first image url
        if let imageUrl = product.images.first {
            
            //Cancel the previous task before starting the new for last row.
            cell.imageTask?.cancel()
            
            cell.imageTask = Task { [weak cell] in
                
                do {
                    // Download the product image
                    let productImage = try await ImageCache.shared.image(for: imageUrl) //downloadProductImage(imageUrl)
                    
                    //Check if the task is already cancelled then no need to update the UI
                    try Task.checkCancellation()
                    
                    // Run the code on main thread in new swift concurrency
                    await MainActor.run {
                        guard let cell = cell else { return }
                        
                        // Check is that cell still visible that has triggered the download of image if yes then only add that image to that cell.
                        guard cell.productId == product.id else { return }
//                        guard let visibleCell = tableView.cellForRow(at: indexPath) as? ProductListCell
//                        else { return }
                        
                        cell.setCellData(product: product, image: productImage)
                    }
                } catch is CancellationError {
                    print("Image download Task cancel for Product: \(product.id)")
                } catch {
                    print("Error in loading image \(#function)")
                }
            }
        } else {
            cell.setCellData(product: product, image: nil)
        }
        
        return cell
    }
    
}

//MARK: - TableViewDelegate
extension ProductListViewController: UITableViewDelegate {
    
}
