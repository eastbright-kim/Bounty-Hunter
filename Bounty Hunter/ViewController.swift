//
//  ViewController.swift
//  Bounty Hunter
//
//  Created by 김동환 on 2021/01/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MVVM
    
    //Model
    // BountyInfo
    
    //View
    // -ListCell
    // -ListCell get needed information from viewmodel
    // Listcell 은 viewmodel로부터 받은 정보로 뷰 업데이트 하기
    
    //ViewModel
    // - bountyviewmodel
    //> bountyviewmodel을 만들고, 뷰레이어에서 필요한 메서드 만들기
    // 모델 가지고 있기, 바운티 인포들

    let viewModel = BountyViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfBountyInfoList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        let bountyInfo = viewModel.bountyInfo(at: indexPath.row)
        
        cell.update(info: bountyInfo)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            let destinationVC = segue.destination as? DetailViewController
            
            if let index = sender as? Int {
                
                let bountyInfo = viewModel.bountyInfo(at: index)

                destinationVC?.viewModel.update(model: bountyInfo)

            }
        }
    }
}

class ListCell: UITableViewCell {
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    func update(info: BountyInfo){
        imgView.image = info.image
        nameLabel.text = info.name
        bountyLabel.text = String(info.bounty)
    }
    
}


class BountyViewModel{
    
    let bountyInfoList: [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 3300000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 4400000),
        BountyInfo(name: "luffy", bounty: 170000),
        BountyInfo(name: "nami", bounty: 40000),
        BountyInfo(name: "robin", bounty: 60000),
        BountyInfo(name: "sanji", bounty: 80000),
        BountyInfo(name: "zoro", bounty: 160000000)
    ]
    
    var sortedList: [BountyInfo] {
        get{
            let sortedList = bountyInfoList.sorted { (prev, next) in
                return prev.bounty > next.bounty
            }
            return sortedList
        }
    }

    var numberOfBountyInfoList: Int {
        return bountyInfoList.count
    }

    func bountyInfo(at index: Int) -> BountyInfo {
        return sortedList[index]
    }
    
}
