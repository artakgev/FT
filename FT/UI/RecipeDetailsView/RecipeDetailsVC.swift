//
//  RecipeDetailsVC.swift
//  FT
//
//  Created by Artak Gevorgyan on 16.11.24.
//

import UIKit
import WebKit

class RecipeDetailsVC: BaseVC, BaseVCProtocol {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var recipeTitleLabel: UILabel!
    @IBOutlet private weak var cusineLabel: UILabel!
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet weak private var webView: WKWebView!
    @IBOutlet weak private var detailsInWebSiteLinkLabel: UILabel!

    // MARK: - Public properties
        
    public var vm: RecipeDetailsVM?
    private var recipes: [Recipe]?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Override methods
    
    func initUIElements() {
        initRecipeTitleLabel()
        initCuisineLabel()
        initPhotoImageView()
        initWebView()
        initLinkLabel()
    }

    // MARK: - VMToVCExchange protocol methods

    override func dataFetched<T>(type: T.Type, data: T?, observerName: String) {
    }

    override func invalidDataErrorReceived<T>(fieldType: T.Type, data: [String: String]) {
        
    }
    
    // MARK: - Private
    // MARK: Init UI elements

    private func initRecipeTitleLabel() {
        self.recipeTitleLabel.text = "Title: " + (self.vm?.recipeObject.name ?? "N/A")
    }

    private func initCuisineLabel() {
        self.cusineLabel.text = "Cusine: " + (self.vm?.recipeObject.cuisine ?? "N/A")
    }

    private func initPhotoImageView() {
        guard let urlString = self.vm?.recipeObject.photoUrlLarge,
              let imageUrl = URL(string: urlString) else { return }
        photoImageView.kf.setImage(with: imageUrl)
    }
    
    private func initWebView() {
        webView.allowsBackForwardNavigationGestures = true
        webView.needsUpdateConstraints()
        if let youtubeURL = self.vm?.recipeObject.youtubeUrl {
            guard let changedUrl = youtubeURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else { return }
            guard let url = URL(string: changedUrl) else { return }
            webView.load(URLRequest(url: url))
        }
    }
    
    private func initLinkLabel() {
        var urlText = "Sorry, bad url"
        if let _ = self.getUrl() {
            urlText = "Click to switch to the browser for more info"
            let tap = UITapGestureRecognizer(target: self,
                                             action: #selector(handleLinkLabelTap))
            detailsInWebSiteLinkLabel.addGestureRecognizer(tap)
            detailsInWebSiteLinkLabel.isUserInteractionEnabled = true
        }
        detailsInWebSiteLinkLabel.text = urlText
        detailsInWebSiteLinkLabel.textColor = .link
    }

    private func getUrl() -> URL? {
        guard let urlStr = self.vm?.recipeObject.sourceUrl,
              let url = URL(string: urlStr) else {
            return nil
        }
        return url
    }
    
    @objc private func handleLinkLabelTap(gesture: UITapGestureRecognizer) {
        if let url = self.getUrl() {
            UIApplication.shared.open(url)
        }
    }
    
}
