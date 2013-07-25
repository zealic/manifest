# Manifest

## 引言
清单仓库，用于管理项目的依赖关系。  

很多时候我们开发的项目可能遇到以下情况：

* 项目复杂，依赖的子项目或父项目都有单独的代码仓库
* 依赖多个第三方库
* 需要对依赖的第三方库做修改(补丁)

Manifest 提出的解决方案是利用 Google 的 [depot_tools](http://www.chromium.org/developers/how-tos/depottools) 的 gclient 工具管理项目的依赖，  
并将所有针对性的补丁进行统一管理。


## 支持环境
* Linux
* Windows


## 使用方式
1. Clone 本仓库。
2. 切换到需要的分支如 _solution-kit_
3. 运行 `@Sync.cmd` 脚本进行仓库同步
4. 运行 `@Patch-Reset.cmd` 重置针对对三方库的补丁
5. 运行 `@Patch.cmd` 应用针对对三方库的补丁


## 如何打补丁
1. 修改 third-party 目录中的第三方库代码。
2. 使用 git diff 产生补丁文件
3. 将补丁文件放到 manifest 仓库的 patches 文件夹中对应的第三方库文件夹  
  如 _third-party/MyProject_ 的补丁文件对应到 _patchs/MyProject_ 目录。


## 其他
如有任何问题请联系维护者。

----

## 参考
* [depot_tools](http://www.chromium.org/developers/how-tos/depottools)
