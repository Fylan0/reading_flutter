# Reading APP Flutter版




------------------------------
## 开发过程记录

### 1、 使用 ：go_router、adaptive_navigation 搭建主页

![go_router、adaptive_navigation 搭建主页](/read_file/screen_1.png)


### 2、书店：书籍列表异步加载逻辑、GridView网格布局

![书店：书籍列表异步加载逻辑、GridView网格布局](/read_file/feature_gridview.png)

### 3、添加导入本地txt文件入口；点击调起文件选择页面

![screen_pick_file_entrance](/read_file/screen_pick_file_entrance.png)

![screen_pick_local_text_file](/read_file/screen_pick_local_text_file.png)

选择后将txt文件中文本进行解析（转成分章节的数据结构），然后分别存入到 图书、图书章节两个数据库表中

### 4、加载本地数据库图书信息，并展示（使用StreamController支持数据库修改后，列表View的动态刷新）

![书架页面](/read_file/screen_bookshelf.png)

### 5、阅读页面

![read.gif](/read_file/read.gif)

------------------------------
# reading_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
