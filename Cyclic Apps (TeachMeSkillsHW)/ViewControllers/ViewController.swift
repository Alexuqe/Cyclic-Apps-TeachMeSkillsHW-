    //
    //  ViewController.swift
    //  Cyclic Apps (TeachMeSkillsHW)
    //
    //  Created by Sasha on 28.12.24.
    //

import UIKit


enum StateAnimation {
    case down
    case right
    case up
    case left
}

final class ViewController: UIViewController {

        //MARK: Outlets
    private let safeView = UIView()
    private let cyrcleView = UIView()

    private let buttonStackView = UIStackView()

    private lazy var startButton = addButton(title: "Start", color: UIColor.systemGreen, size: CGSize(width: sizeButton, height: sizeButton / 2))
    private lazy var stopButton = addButton(title: "Stop", color: UIColor.red, size: CGSize(width: sizeButton, height: sizeButton / 2))

        //MARK: Private Properties
    private let leadingConstraints: CGFloat = 50
    private let trailingConstraints: CGFloat = -50
    private let sizeCyrcle: CGFloat = 60
    private lazy var sizeButton: CGFloat = 120
    private var stateAnimate = false

        //MARK: Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        updateUI()
    }

    override func viewDidLayoutSubviews() {
        cornerRadius(cyrcleView)
        cornerRadius(startButton)
        cornerRadius(stopButton)
    }

}

    //MARK: Private Extension ViewController
private extension ViewController {

        //MARK: UI Update
    func updateUI() {
        configureSafeView()
        configureCyrcleView()

        view.addSubview(startButton)
        sizeButton(startButton)

        view.addSubview(stopButton)
        sizeButton(stopButton)

        configureButtonStackView()

        actionButtons()
    }

        //MARK: UI Setup
    func configureSafeView() {
        safeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(safeView)

        constraintsSafeView()
    }

    func configureCyrcleView() {
        cyrcleView.backgroundColor = .systemGreen
        cyrcleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cyrcleView)

        constraintsCyrcleView()
    }

    func configureButtonStackView() {
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 20

        buttonStackView.addArrangedSubview(startButton)
        buttonStackView.addArrangedSubview(stopButton)

        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStackView)

        contraintsButtonStackView()
    }


        //MARK: UI Constraints
    func constraintsSafeView() {
        NSLayoutConstraint.activate(
            [
                safeView.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: leadingConstraints
                ),
                safeView.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: trailingConstraints
                ),
                safeView.centerYAnchor.constraint(
                    equalTo: view.centerYAnchor
                ),
                safeView.heightAnchor.constraint(
                    equalTo: safeView.widthAnchor
                )
            ]
        )
    }

    func constraintsCyrcleView() {
        NSLayoutConstraint.activate(
            [
                cyrcleView.widthAnchor.constraint(
                    equalToConstant: sizeCyrcle
                ),
                cyrcleView.heightAnchor.constraint(
                    equalTo: cyrcleView.widthAnchor
                ),
                cyrcleView.leadingAnchor.constraint(
                    equalTo: safeView.leadingAnchor
                ),
                cyrcleView.topAnchor.constraint(
                    equalTo: safeView.topAnchor
                )
            ]
        )
    }

    func contraintsButtonStackView() {
        NSLayoutConstraint.activate(
            [
                buttonStackView.bottomAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                    constant: -20
                ),
                buttonStackView.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: leadingConstraints
                ),
                buttonStackView.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: trailingConstraints
                )
            ]
        )
    }


        //MARK: UI Helper
    func addButton(title: String, color: UIColor, size: CGSize = CGSize(width: 0 , height: 0)) -> UIButton {
        {
        var configure = UIButton.Configuration.plain()
        configure.baseForegroundColor = .white
        configure.cornerStyle = .capsule
        configure.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        $0.configuration = configure
        $0.frame.size = size
        $0.setTitle(title, for: .normal)
        $0.backgroundColor = color
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0
        }(UIButton())
    }

    func sizeButton(_ button: UIButton) {
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: sizeButton),
            button.heightAnchor.constraint(equalToConstant: sizeButton / 2)
        ])
    }

    func cornerRadius(_ view: UIView) {
        view.layer.cornerRadius = view.frame.height / 2
    }

        //MARK: Ations
    func actionButtons() {
        startButton.addTarget(self, action: #selector(startCycle), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopCycle), for: .touchUpInside)
    }

    @objc func startCycle() {
        guard !stateAnimate else { return }
        stateAnimate = true

        animating(state: .down)
    }

    func animating(state: StateAnimation) {
        guard stateAnimate else { return }
        switch state {
            case .down:
                UIView.animate(withDuration: 1) { [weak self] in
                    guard let self else { return }
                    self.cyrcleView.transform = CGAffineTransform(translationX: self.safeView.bounds.origin.x, y: self.safeView.bounds.height - self.sizeCyrcle)
                } completion: { [weak self] _ in
                    self?.animating(state: .right)
                }
            case .right:
                UIView.animate(withDuration: 1) { [weak self] in
                    guard let self else { return }
                    self.cyrcleView.transform = CGAffineTransform(translationX: self.safeView.bounds.width - self.cyrcleView.frame.height, y: self.safeView.bounds.height - self.sizeCyrcle)
                } completion: { [weak self] _ in
                    self?.animating(state: .up)
                }
            case .up:
                UIView.animate(withDuration: 1) { [weak self] in
                    guard let self else { return }
                    self.cyrcleView.transform = CGAffineTransform(translationX: self.safeView.frame.width - self.sizeCyrcle, y: 0 )
                } completion: { [weak self] _ in
                    self?.animating(state: .left)
                }
            case .left:
                UIView.animate(withDuration: 1) { [weak self] in
                    guard let self else { return }
                    self.cyrcleView.transform = CGAffineTransform(translationX: 0, y: 0)
                } completion: { [weak self] _ in
                    self?.animating(state: .down)
                }
        }
    }

    @objc func stopCycle() {
        guard !stateAnimate else {
            stateAnimate = false
            UIView.animate(withDuration: 1) { [weak self] in
                guard let self else { return }
                self.cyrcleView.transform = .identity
            }
            return
        }
    }




}

