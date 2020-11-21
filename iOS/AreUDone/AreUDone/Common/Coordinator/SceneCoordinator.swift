//
//  AppCoordinator.swift
//  AreUDone
//
//  Created by 서명렬 on 2020/11/18.
//

import NetworkFramework
import UIKit

final class SceneCoordinator: Coordinator {
  
  // MARK: - Property
  
  private var window: UIWindow?
  private let initCoordinatorFactory: CoordinatorFactoryable
  private let signinChecker: SigninCheckable
  private let router: Router
  
  
  // MARK: - Initializer
  
  init(
    window: UIWindow?,
    router: Router,
    factory: CoordinatorFactoryable,
    signinChecker: SigninCheckable
  ) {
    self.window = window
    self.router = router
    initCoordinatorFactory = factory
    self.signinChecker = signinChecker
  }
  
  
  // MARK: - Method
  
  func start() -> UIViewController {
    var signinCheckResult = signinChecker.check()
    signinCheckResult = .isSigned // TODO: 로그인 API 완성되면 삭제
    
    let initCoordinator = initCoordinatorFactory.coordinator(
      by: signinCheckResult,
      with: router
    )
    let initViewController = initCoordinator.start()
    window?.rootViewController = initViewController
    window?.makeKeyAndVisible()
    
    return initViewController
  }
}
