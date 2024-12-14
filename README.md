<a id="readme-top"></a>
<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#关于项目">关于项目</a>
      <ul>
        <li><a href="#项目设计思路">项目设计思路</a></li>
      </ul>
      <ul>
        <li><a href="#项目架构">项目架构</a></li>
      </ul>
    </li>
    <li>
      <a href="#运行项目">运行项目</a>
      <ul>
        <li><a href="#环境">环境</a></li>
        <li><a href="#安装">安装</a></li>
      </ul>
    </li>
    <li><a href="#使用">使用</a></li>
    <li><a href="#许可">许可</a></li>
  </ol>
</details>


<!-- ABOUT THE PROJECT -->
## 关于项目

**ArcBlockApp** 是一个实现获取blog列表的应用程序，可以点击分类标签以及详情进行跳转，采用了 **Clean Architecture** 和 **MVVM** 设计模式。该项目旨在展示通过清晰的架构，并使用依赖注入（Dependency Injection）来来达到可测试，实现模块化，以及后续模块复用。

### 项目设计思路

1. 类与类模块与模块之间尽量采用协议进行接口，模块依赖尽量采用抽象接口不是具体的类
2. 采用依赖注入（主要是提供类的初始化）方式，提供app注入管理类，向模块注入管理类提供基础服务（如数据服务等）。
3. 控制器跳转要做统一协调,解耦依赖。


### 项目架构

整个项目按照 **Clean Architecture** 进行分层，主要包括以下三个层级：

* **Domain Layer** = Entities + Use Cases + Repositories Interfaces
* **Data Repositories Layer** = Repositories Implementations + （datalayer）
* **Presentation Layer (MVVM)** = ViewModels + Views

#### 1. Domain Layer

**Domain 层**主要包含业务逻辑和实体模型。该层对业务规则进行定义和封装。

##### 1.1 Entities

- `Blog.swift`：定义了博客的实体模型。
- `BlogQuery.swift`：定义获取博客列表时所需的请求参数。

##### 1.2 Use Cases

- `FetchBlogQueriesUseCase.swift`：定义获取博客列表的核心用例逻辑，即应用的业务行为。

##### 1.3 Repositories Interfaces

- `BlogRepository.swift`：定义了获取博客列表的数据来源接口。  


**说明:** **Domain Layer**
层中仅定义访问数据的方式(纯业务层)，不关心底层数据的实现（如网络请求、本地数据），具体的实现细节由 Data 层去完成。


#### 2. Data Layer

**Data 层**主要包含数据加载部分，此处为数据提供方，由于本项目为了方便演示采用本地json数据，后续如果采用网络接口，网络接口只需要实现Domain Layer的BlogRepository接口即可切换成本极低。

##### 2.1 LocalData

- `LocalDataConfig.swift`：本地数据配置
- `LocalDataService.swift`：本地数据服务，实现BlogRepository数据接口加载数来源。


#### 3. Presentation Layer

**Presentation Layer 层**主要包含页面展示部分，包括view以及viewmodel部分。

##### 3.1 view

- `BlogDetailsViewController.swift,BlogListTableViewController`：webview控制器,列表控制器(页面viewmodel绑定)

##### 3.1 ViewModels
- `BlogListViewModel.swift`：列表数据VIewmodel，负责数据到cell的viewModel转化。
- `BlogListItemViewModel.swift` cell的viewModel。

**说明:** **Presentation Layer**
BlogDetailsViewController之所以归到view层下，是因为控制器主要也在在实现页面逻辑。


<!-- 运行项目 -->
## 运行项目

### 环境
 
 Xcode Version 16.2  Swift 5.0+


### 安装

1. Clone 项目
   ```sh
   git clone https://github.com/suddenly1990/ArcBlockApp.git
   ```
2 . 使用xcode打开工程运行项目
    
    

<!-- USAGE EXAMPLES -->
## 使用

使用Xcode打开工程根运行根目录下的ArcBlockApp.xcodeproj

<!-- LICENSE -->
## 许可

MIT license

<p align="right">(<a href="#readme-top">back to top</a>)</p>

