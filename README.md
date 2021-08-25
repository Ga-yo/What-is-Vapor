# What-is-Vapor
Server-side Swift with Vapor



### Vapor 폴더 구조 정리

- Package.swift

  SPM이 프로젝트에서 가장 먼저 찾는 파일로 패키지의 의존성과 타깃 등을 정의한다. 이 파일은 항상 프로젝트의 루트 디렉토리에 위치한다.

- Sources

  프로젝트의 모든 Swift 소스 파일을 포함한다.

  - App

    앱을 구성하는데 필요한 코드를 포함한다.

    - Controllers

      로직을 그룹화하는 컨트롤러가 위치한다.

    - Migrations

      데이터베이스 마이그레이션을 정의하는 타입이 위치한다.

    - Models

      데이터베이스의 데이터 구조를 나타내는 모델이 위치한다.

    - configure.swift

      앱을 구성하는 <code>configure(_:)</code> 함수를 포함한다. <code>main.swift</code> 에 의해 호출되며 이 함수에 라우트, 데이터베이스 등의 서비스를 등록해야한다.

    - route.swift

      앱에 라우트를 등록하는 <code>route(_:)</code> 함수를 포함하며, <code>configure(-:)</code> 함수에 의해 호출된다.

  - Run

    앱을 실행하는데 필요한 코드만 포함된다.

    - main.swift

      앱의 인스턴스를 생성하고 실행한다.

- Tests

  <code>XCTVapor</code> 모듈을 사용하는 단위 테스트를 포함한다.



### SwiftNIO? 🤔

 Apple에서 만든 SwiftNIO 프레임워크를 기반으로 설계되었다. SwiftNIO는 비동기 네트워킹 프레임워크로 Vapor의 모든 HTTP 통신을 처리한다. Vapor가 요청을 받고 응답을 보낼 수 있게 하며, 연결 및 데이터 전송을 관리한다.

 Vapor의 일부 API는 <code>EventLoopFuture</code> 제네릭 타입을 반환한다. <code>EventLoopFuture</code> 는 나중에 제공될 결과에 대한 플레이스홀더이다. 비동기적으로 동작하는 함수는 실제 데이터를 즉시 반환하지 않고 <code>EventLoopFuture</code> 를 반환한다.



### Fluent?

 Swift용 ORM 프레임워크이다. Vapor 앱과 데이터베이스 사이의 추상화 계층으로 데이터베이스를 쉽게 사용할 수 있도록 인터페이스를 제공한다. 따라서 SQL을 작성하지 않고도 Swift로 데이터베이스 작업을 수행할 수 있다.
