//
//  ViewController.swift
//  BSU Helper
//
//  Created by Ilya Sysoi on 4/28/18.
//  Copyright © 2018 isysoi. All rights reserved.
//

import UIKit

class BSUFacultiesViewController: UIViewController {

    private var contentView: UICollectionView!
    private var facultyItems: [FacultyItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        initFacultyItems()
        
        confiqureContentView()
        
    }
    
    private func confiqureContentView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: view.frame.width-40, height: 80)
        
        contentView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
        contentView.dataSource = self
        contentView.delegate = self
        contentView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        contentView.backgroundColor = .white
        
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    private func initFacultyItems() {
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: "Faculties", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
            let faculties = myDict?.value(forKey: "Faculties") as! [[String: AnyObject]]
                for item in faculties {
                    let facultyItem = FacultyItem(id: item["id"]! as! Int,
                                                  logoName: item["logo"] as! String,
                                                  name: item["name"] as! String)
                    facultyItems.append(facultyItem)
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

extension BSUFacultiesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return facultyItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        myCell.contentView.addSubview(FacultyPreview(item: facultyItems[indexPath.row]))
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let vc = FacultyViewController(item: facultyItems[indexPath.row])
        present(vc, animated: true)
    }

    
}
