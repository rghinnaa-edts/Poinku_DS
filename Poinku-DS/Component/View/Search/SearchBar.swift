//
//  Search.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 18/03/25.
//

import UIKit

class Search: UISearchBar {
    
    private var searchText: String?
    private var placeholderText: String = "Search"

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initUI()
    }
    
    init(searchText: String? = nil, placeholderText: String = "Search") {
        self.searchText = searchText
        self.placeholderText = placeholderText
        super.init(frame: .zero)
        
        initUI()
    }
    
    private func initUI() {
        super.searchBarStyle = .minimal
        super.placeholder = placeholderText
        
        self.delegate = self
        self.backgroundImage = UIImage()
        
        if let textField = getSearchTextField() {
            textField.layer.borderWidth = 1
            textField.layer.cornerRadius = 8
            textField.layer.borderColor = UIColor.Grey.grey30.cgColor
            
            textField.clipsToBounds = true
            textField.backgroundColor = .white
            
            textField.font = Font.Body.B3.Small.font
        }
    }
    
    func getSearchTextField() -> UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            if let textField = self.value(forKey: "searchField") as? UITextField {
                return textField
            }
            
            for subview in self.subviews {
                for innerSubview in subview.subviews {
                    if let textField = innerSubview as? UITextField {
                        return textField
                    }
                }
            }
            return nil
        }
    }
    
}

extension Search: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let textField = getSearchTextField() {
            textField.layer.borderColor = UIColor.Blue.blue10.cgColor
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let textField = getSearchTextField() {
            textField.layer.borderColor = UIColor.Grey.grey30.cgColor
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        
        if let textField = getSearchTextField() {
            textField.layer.borderColor = UIColor.Grey.grey30.cgColor
        }
    }
}
