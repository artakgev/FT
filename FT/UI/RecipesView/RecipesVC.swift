//
//  RecipesVC.swift
//  FT
//
//  Created by Artak Gevorgyan on 16.11.24.
//

import UIKit

class RecipesVC: BaseVC, BaseVCProtocol {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Public properties
    
    
    public var vm = RecipesVM()
    
    private var recipes: [Recipe]?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.getRecipes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Override methods
    
    func initUIElements() {
        initTableView()
    }
    
    // MARK: - VMToVCExchange protocol methods

    override func dataFetched<T>(type: T.Type, data: T?, observerName: String) {
        switch type {
        case is [Recipe].Type:
            guard let safeRecipes = data as? [Recipe] else {return}
            self.recipes = safeRecipes
            print(recipes)
            tableView.reloadData()
        default:
            break
        }
    }

    override func invalidDataErrorReceived<T>(fieldType: T.Type, data: [String: String]) {
        
    }
    
    // MARK: - Private
    // MARK: Init UI elements

    private func initTableView() {
        tableView.registerCell(RecipeCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource methods

extension RecipesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(ofType: RecipeCell.self) else {
            return UITableViewCell()
        }
        if let recipe = self.recipes?[indexPath.row] {
            let model = recipe
            cell.model = model
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let recipe = self.recipes?[indexPath.row] {
            self.vm.openRecipeDetailsView(recipe: recipe)
        }
    }
   
}
