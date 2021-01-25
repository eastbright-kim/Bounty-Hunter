//
//  ViewController.swift
//  Bounty Hunter
//
//  Created by 김동환 on 2021/01/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    
    //UICollectionViewlDataSource
    //몇개를 보여줄까요?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfBountyInfoList
    }
    //셀은 어떻게 표현할까요?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as? GridCell else {
            return UICollectionViewCell()
        }
        
        let bountyInfo = viewModel.bountyInfo(at: indexPath.item)
        
        cell.update(info: bountyInfo)
        
        return cell
    }
    
    //UICollectionViewDelegate
    //셀이 클릭되었을때 어쩔까요?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: indexPath.item)
    }
    
    //UICollectionViewDelegateFlowLayout
    //셀사이즈를 계산할거다 (목표: 다양한 디바이스에서 일관적인 디자인을 보여주기 위해)
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSpacing: CGFloat = 10
        let textAreaHeight: CGFloat = 65
        
        let width: CGFloat = (collectionView.bounds.width - itemSpacing) / 2
        let height: CGFloat = width * 10/7 + textAreaHeight

        return CGSize(width: width, height: height)
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

class GridCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    func update(info: BountyInfo){
        imgView.image = info.image
        nameLabel.text = info.name
        bountyLabel.text = String(info.bounty)
    }
}
