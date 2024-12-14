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

# ArcBlockApp

**ArcBlockApp** 是一个用于展示博客列表的应用程序，支持点击分类标签和博客详情页面进行跳转。  
该项目采用 **Clean Architecture** 和 **MVVM** 设计模式，旨在通过清晰的架构设计，实现以下目标：

- **可测试性**
- **模块化开发**
- **模块的高复用性**


## 项目设计思路

1. **模块解耦**：
- 尽量依赖抽象，模块之间通过协议进行接口定义，避免直接依赖具体的类。

2. **依赖注入**：
- 使用依赖注入（Dependency Injection）进行类的初始化，确保模块的灵活性。
- 提供应用级注入管理器，将基础服务（如数据服务等）注入到各模块中。

3. **统一跳转管理**：
- 控制器之间的跳转通过统一的协调器（Coordinator）进行管理。
- 避免控制器直接耦合，提升项目的可维护性和扩展性。

4. **提供应用配置项**：
- 提供应用级别配置项,设定app全局系统配置,加载统一全局配置（启发思路来自info.plist）

### 项目架构

整个项目按照 **Clean Architecture** 进行分层，主要包括以下三个层级：

* **Domain Layer** = Entities + Use Cases + Repositories Interfaces
* **Data Repositories Layer** = Repositories Implementations + （datalayer）
* **Presentation Layer (MVVM)** = ViewModels + Views

#### 依赖方向
![依赖图](README_FILE/CleanArchitectureDependencies.png?raw=true "Modules Dependencies")


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

- `BlogWebViewController.swift,BlogListTableViewController.swift`：webview控制器(跳转详情和类别),列表控制器(页面viewmodel绑定)
- `BlogListItemCell.swift,TagsView.swift`：列表cellview,流式布局控件

##### 3.1 ViewModels
- `BlogListViewModel.swift`：列表数据VIewmodel，负责数据到cell的viewModel转化。
- `BlogListItemViewModel.swift` cell的viewModel。

**说明:** **Presentation Layer**
BlogWebViewController 和 BlogDetailsViewController 被归入 View 层，是因为其中的业务逻辑已经被拆分，控制器的主要职责是处理页面的展示逻辑和用户交互。


<!-- 运行项目 -->
## 运行项目

### 环境
 
 Xcode Version 16.2  Swift 5.0+


### 安装

1. Clone 项目
   ```sh
   git clone https://github.com/suddenly1990/ArcBlockApp.git
   ```    
    

<!-- USAGE EXAMPLES -->
## 使用

1. 进入项目根目录下，找到ArcBlockApp.xcodeproj
2. 使用Xcode打开ArcBlockApp.xcodeproj文件
3. 等待依赖package加载完成
4. 可以选择真机或者模拟器链接，点击xcode三角按钮或者（product-> run）进行运行

<!-- LICENSE -->
## 许可

MIT license Copyright (c) 2024

<p align="right">(<a href="#readme-top">back to top</a>)</p>

