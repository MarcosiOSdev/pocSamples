//
//  StackCardsViewController.swift
//  app-test
//
//  Created by mfelipesp on 30/08/24.
//

import UIKit

struct CardModel {
    let title: String
    let color: UIColor
}

class StackCardsViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private let cellIdentifier = "CardCell"
    private var cards: [CardModel] = [
        CardModel(title:"Card Banking", color:UIColor.systemBlue),
        CardModel(title:"Card Compount", color:UIColor.systemGreen),
        CardModel(title:"Card Tarjetas", color:UIColor.systemGray),
        CardModel(title:"Card Ativities", color: UIColor.systemPink),
        CardModel(title:"Card Anyaway", color: UIColor.systemBlue),
        CardModel(title:"Card Tarjetas 2", color: UIColor.systemGray),
        CardModel(title:"Card Compount 2", color: UIColor.systemGreen)
    ]
    
    // Configurações de layout
    private let cardHeight: CGFloat = 200
    private let minimizedCardHeight: CGFloat = 60
    private let cardSpacing: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = StackFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width - 20, height: 200)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cardSpacing
        layout.delegate = self
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.contentInsetAdjustmentBehavior = .always
        
        // Configurações para scroll mais suave
        collectionView.decelerationRate = .normal
        collectionView.isPrefetchingEnabled = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        
        
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    var yPositionAllowScroll: CGFloat = 0
}

extension StackCardsViewController: StackFlowLayoutDelegate {
    func yPositionAllowScroll(y: CGFloat) {
        yPositionAllowScroll = y
    }
}

extension StackCardsViewController: UIScrollViewDelegate, UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Defina o limite máximo para a rolagem Y
//        let maxOffsetY: CGFloat = 0  // Defina o valor que você deseja como limite
//
//        // Verifique a posição atual do contentOffset Y
//        if scrollView.contentOffset.y > maxOffsetY {
//            // Limite a rolagem para não passar do limite
//            scrollView.contentOffset.y = maxOffsetY
//        }
    }
}

extension StackCardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count // Número de items na sua lista
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CardCell
        
        cell?.configure(cardModel: cards[indexPath.item])
        
        return cell ?? UICollectionViewCell(frame: .zero)
    }
}

protocol StackFlowLayoutDelegate: AnyObject {
    func yPositionAllowScroll(y: CGFloat)
}

class StackFlowLayout: UICollectionViewFlowLayout {
    // Configurações de layout
    private let standardHeight: CGFloat = 200 // Altura padrão do card
    private let stackedHeight: CGFloat = 50   // Altura quando empilhado
    private let maximumVisibleItems = 5       // Número máximo de items empilhados
    private let alphaIncrease: CGFloat = 0.0 // Alpha que vai aumentando a cada stack.
    
    private var yPositionAllowScroll: CGFloat = 0 {
        didSet {
            delegate?.yPositionAllowScroll(y: yPositionAllowScroll)
        }
    }
    
    weak var delegate: StackFlowLayoutDelegate?
    
    override func prepare() {
        super.prepare()
        
        // Configuração básica do layout
        scrollDirection = .vertical
        minimumLineSpacing = 10
        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 1. Obtém os atributos base do layout pai e faz uma cópia segura
        guard let attributes = super.layoutAttributesForElements(in: rect)?.map({ $0.copy() as! UICollectionViewLayoutAttributes }),
              let collectionView = collectionView else {
            return nil
        }
        
        // 2. Obtém a posição atual do scroll
        let contentOffset = collectionView.contentOffset.y
        
        // 3. Processa cada célula individualmente
        for attribute in attributes {
            let indexPath = attribute.indexPath
            // 4. Calcula a posição do item em relação à área visível
            let itemPosition = attribute.frame.origin.y - contentOffset
            
            // 6. Calcula a posição na pilha (0, 1, 2, etc.)
            let stackPosition = CGFloat(min(indexPath.item, maximumVisibleItems - 1))
            
            // Se o item estiver acima da área visível (itemPosition < 0)
            // animacao começa a partir daqui ! 
            if itemPosition < (100 * stackPosition) {
                
                
                // 7. Calcula a escala para cada card (0.85, 0.90, 0.95, etc.)
                // Defina o valor máximo para a escala, para não passar da Edge do iPhone
                let maxScale: CGFloat = 1.05
                let scale = min(0.95 + (0.05 * stackPosition), maxScale)
                
                // Get y value of collectionView in superview.
                let collectionViewPositionInSuperview = collectionView.convert(collectionView.bounds.origin, to: collectionView.superview!)
                
                // Value Y of the collectionView + safeArea
                let yPositionCollectionView: CGFloat = collectionViewPositionInSuperview.y + collectionView.safeAreaInsets.top
                
                // 8. Calcula a nova posição Y do card na pilha
                let yPosition = contentOffset + (stackedHeight * stackPosition) + yPositionCollectionView
                
                // 9. Aplica as transformações
                UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
                    attribute.frame.origin.y = yPosition           // Nova posição
                    attribute.transform = CGAffineTransform(scaleX: scale, y: scale) // Nova escala
                    attribute.zIndex = 1000 + indexPath.item      // Ordem de empilhamento
                    attribute.alpha = 1.0 - (self.alphaIncrease * stackPosition) // Transparência
                }, completion: nil)
                
                // add last height to scroll
                yPositionAllowScroll = yPosition + (attribute.frame.size.height / 2)
            } else {
                // 10. Se o item estiver na área visível normal
                UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
                    attribute.transform = .identity // Remove transformações
                    attribute.alpha = 1.0          // Totalmente visível
                    attribute.zIndex = 0           // Z-index normal ( passando por traz )
                    attribute.zIndex = 2000 + indexPath.item  // Z-index normal (passando o card pela frente)
                }, completion: nil)
                
                yPositionAllowScroll -= (attribute.frame.size.height / 2)
            }
        }
        
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

}



class CardCell: UICollectionViewCell {
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(cardView)
        cardView.addSubview(titleLabel)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
        ])
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    func configure(cardModel: CardModel) {
        titleLabel.text = cardModel.title
        cardView.backgroundColor = cardModel.color
    }
}
