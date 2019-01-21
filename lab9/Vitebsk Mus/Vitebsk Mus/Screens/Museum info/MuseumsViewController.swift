//
//  MuseumsViewController.swift
//  Vitebsk Mus
//
//  Created by Ilya Sysoi on 5/5/18.
//  Copyright © 2018 isysoi. All rights reserved.
//

import UIKit
import CoreData
import MBProgressHUD

class MuseumsViewController: UIViewController {

    private var nameLabel: UILabel
    private var backButton: UIButton
    private var museumsTableView: UITableView
    private var museums: [String] = []
    private var presenter: MuseumsPresenter
    private var weatherInfo: UILabel
    private var activityIndicator: MBProgressHUD!
    
    init(name: String) {
        nameLabel = UILabel()
        nameLabel.text = name
        backButton = UIButton(type: .system)
        museumsTableView = UITableView()
        weatherInfo = UILabel()
        presenter = MuseumsPresenter()
        
        super.init(nibName: nil, bundle: nil)
        initData(nameID: name)
    }
    
    private func initData(nameID: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<MuseumsInfo>(entityName: "MuseumsInfo")
        do {
            fetchRequest.predicate = NSPredicate(format: "nameID == %@", nameID)
            let fetchedResults = try context.fetch(fetchRequest) as! [NSManagedObject]
            print(fetchedResults.count)
            museums = fetchedResults.map {
                return $0.value(forKey: "name") as! String
            }
        }
        catch {
            print ("fetch task failed", error)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = .white
        
        confiqureSubviews()
        addSubviews()
        confiqureConstraints()
        
        presenter.onViewDidLoad(view: self, city: nameLabel.text!)
    }

    private func confiqureSubviews() {
        nameLabel.textAlignment = .center
        
        backButton.setTitle("<", for: .normal)
        backButton.addTarget(self,
                             action: #selector(backButtonTapped),
                             for: .touchUpInside)
        
        museumsTableView.delegate = self
        museumsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        museumsTableView.backgroundColor = .white
        museumsTableView.separatorStyle = .none
        museumsTableView.rowHeight = UITableViewAutomaticDimension
        museumsTableView.estimatedRowHeight = 140
    }

    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    private func addSubviews() {
        view.addSubview(nameLabel)
        view.addSubview(backButton)
        view.addSubview(weatherInfo)
        view.addSubview(museumsTableView)
    }
    
    private func confiqureConstraints() {
        backButton.snp.makeConstraints { make in
            make.left.equalTo(view)
            make.centerY.equalTo(nameLabel)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(10)
        }
        
        weatherInfo.snp.makeConstraints { make in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
        
        museumsTableView.snp.makeConstraints { make in
            make.top.equalTo(weatherInfo.snp.bottom).offset(20)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func initActivityIndicator() {
        activityIndicator = MBProgressHUD.showAdded(to: view, animated: true)
        activityIndicator.mode = .indeterminate
    }
    

}

extension MuseumsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return museums.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(museums[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: "cell"),
                                                 for: indexPath)
        let label = UILabel()
        label.text = museums[indexPath.row]
        label.numberOfLines = 2
        cell.contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(cell.contentView).offset(20)
            make.right.equalTo(cell.contentView).offset(-20)
            make.centerY.equalTo(cell.contentView)
        }
        
        return cell
    }
    
}

extension MuseumsViewController: MuseumsViewProtocol {
    func setActivityIndicator(isVisible: Bool) {
        isVisible ? initActivityIndicator() : activityIndicator.hide(animated: true)
    }
    
    
    func setWeatherInfo(temp: String) {
        weatherInfo.text = "Температура \(temp) F"
        museumsTableView.dataSource = self
    }
    
    
}
