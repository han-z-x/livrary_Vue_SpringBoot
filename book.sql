/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : book

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 13/06/2021 07:15:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pwd` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (101, '沐辰', 'root', '123456', '13633465455');

-- ----------------------------
-- Table structure for appoint
-- ----------------------------
DROP TABLE IF EXISTS `appoint`;
CREATE TABLE `appoint`  (
  `book_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stu_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `appoint_date` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_stu_id`(`stu_id`) USING BTREE,
  INDEX `app_book_id`(`book_id`) USING BTREE,
  CONSTRAINT `app_book_id` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_stu_id` FOREIGN KEY (`stu_id`) REFERENCES `student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of appoint
-- ----------------------------

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `author` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sort` int(10) NOT NULL,
  `bookdesc` varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `count` int(2) NOT NULL DEFAULT 10,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `book_sort`(`sort`) USING BTREE,
  CONSTRAINT `book_sort` FOREIGN KEY (`sort`) REFERENCES `sort` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '廖雪峰Java', '廖雪峰', 1, 'Java是一门面向对象编程语言，不仅吸收了C++语言的各种优点，还摒弃了C++里难以理解的多继承、指针等概念，因此Java语言具有功能强大和简单易用两个特征。Java语言作为静态面向对象编程语言的代表，极好地实现了面向对象理论，允许程序员以优雅的思维方式进行复杂的编程', 20);
INSERT INTO `book` VALUES (2, 'c++算法珠玑', 'c++1', 3, '算法珠玑(C++版)——一个最精简的题库，本书的目标读者是准备去硅谷找工作的码农，也适用于在国内找工作的码农，以及刚接触ACM算法竞赛的新手。', 9);
INSERT INTO `book` VALUES (3, '你好，么么哒', '大冰', 4, '你好', 22);
INSERT INTO `book` VALUES (4, 'Springboot 开源电子书', 'SpringBoot官方', 1, 'Spring Boot是由Pivotal团队提供的全新框架，其设计目的是用来简化新Spring应用的初始搭建以及开发过程。该框架使用了特定的方式来进行配置，从而使开发人员不再需要定义样板化的配置。通过这种方式，Spring Boot致力于在蓬勃发展的快速应用开发领域(rapid application development)成为领导者。', 10);
INSERT INTO `book` VALUES (5, 'SpringCloud教程', 'SpringCloud官方', 1, 'Spring Cloud Tutorial 是一本关于 Spring Cloud 学习的开源书。利用业余时间写了本书，图文并茂，用大量实例带你一步一步走进 Spring Cloud 的世界。如有疏漏欢迎指正，欢迎提问。感谢您的参与！', 10);
INSERT INTO `book` VALUES (6, 'Java高级应用', '陈昊鹏', 1, '本书赢得了全球程序员的广泛赞誉，即使是最晦涩的概念，在Bruce Eckel的文字亲和力和小而直接的编程示例面前也会化解于无形。从Java的基础语法到最高级特性（深入的面向对象概念、多线程、自动项目构建、单元测试和调试等），本书都能逐步指导你轻松掌握。', 9);
INSERT INTO `book` VALUES (7, '深入理解Java虚拟机', '周志明', 1, '《深入理解Java虚拟机:JVM高级特性与最佳实践(第2版)》内容简介：第1版两年内印刷近10次，4家网上书店的评论近4?000条，98%以上的评论全部为5星级的好评，是整个Java图书领域公认的经典著作和超级畅销书，繁体版在台湾也十分受欢迎。第2版在第1版的基础上做了很大的改进：根据最新的JDK 1.7对全书内容进行了全面的升级和补充；增加了大量处理各种常见JVM问题的技巧和最佳实践；增加了若干与生产环境相结合的实战案例；对第1版中的错误和不足之处的修正；等等。第2版不仅技术更新、内容更丰富，而且实战性更强。', 9);
INSERT INTO `book` VALUES (8, 'JAVA核心技术', 'Cay S. Horstmann', 1, '《JAVA核心技术(卷1):基础知识(原书第8版)》是《Java核心技术》的最新版，《Java核心技术》出版以来一直畅销不衰，深受读者青睐，每个新版本都尽可能快地跟上Java开发工具箱发展的步伐，而且每一版都重新改写了的部分内容，以便适应Java的最新特性。本版也不例外，它反遇了Java SE6的新特性。全书共14章，包括Java基本的程序结构、对象与类、继承、接口与内部类、图形程序设计、事件处理、Swing用户界面组件、部署应用程序和Applet、异常日志断言和调试、叙述方式深入浅出，并包含大量示例，从而帮助读者充分理解Java语言以及Java类型库的相关特性。', 9);
INSERT INTO `book` VALUES (9, 'Python编程', '埃里克·马瑟斯', 2, '本书是一本针对所有层次的Python 读者而作的Python 入门书。全书分两部分：第一部分介绍用Python 编程所必须了解的基本概念，包括matplotlib、NumPy 和Pygal 等强大的Python 库和工具介绍，以及列表、字典、if 语句、类、文件与异常、代码测试等内容；第二部分将理论付诸实践，讲解如何开发三个项目，包括简单的Python 2D 游戏开发如何利用数据生成交互式的信息图，以及创建和定制简单的Web 应用，并帮读者解决常见编程问题和困惑。', 9);
INSERT INTO `book` VALUES (10, 'Python深度学习', '弗朗索瓦•肖莱', 2, '本书由Keras之父、现任Google人工智能研究员的弗朗索瓦•肖莱（François Chollet）执笔，详尽介绍了用Python和Keras进行深度学习的探索实践，涉及计算机视觉、自然语言处理、生成式模型等应用。书中包含30多个代码示例，步骤讲解详细透彻。由于本书立足于人工智能的可达性和大众化，读者无须具备机器学习相关背景知识即可展开阅读。在学习完本书后，读者将具备搭建自己的深度学习环境、建立图像识别模型、生成图像和文字等能力。', 10);
INSERT INTO `book` VALUES (11, '利用Python进行数据分析', ' Wes McKinney', 2, '“科学计算和数据分析社区已经等待这本书很多年了：大量具体的实践建议，以及大量综合应用方法。本书在未来几年里肯定会成为Python领域中技术计算的权威指南。”', 10);
INSERT INTO `book` VALUES (12, 'Python编程快速上手', 'Albert Sweigart', 2, '如今，人们面临的大多数任务都可以通过编写计算机软件来完成。Python是一种解释型、面向对象、动态数据类型的高级程序设计语言。通过Python编程，我们能够解决现实生活中的很多任务。', 10);
INSERT INTO `book` VALUES (13, 'Python学习手册（第4版）', 'Mark Lutz', 2, 'Google和YouTube由于Python的高可适应性、易于维护以及适合于快速开发而采用它。如果你想要编写高质量、高效的并且易于与其他语言和工具集成的代码，《Python学习手册：第4 版》将帮助你使用Python快速实现这一点，不管你是编程新手还是Python初学者。本书是易于掌握和自学的教程，根据作者Python专家Mark Lutz的著名培训课程编写而成。', 10);
INSERT INTO `book` VALUES (14, 'Linux多线程服务端编程', '陈硕', 3, '本书主要讲述采用现代C++ 在x86-64 Linux 上编写多线程TCP 网络服务程序的主流常规技术，重点讲解一种适应性较强的多线程服务器的编程模型，即one loop per thread。这是在Linux 下以native 语言编写用户态高性能网络程序最成熟的模式，掌握之后可顺利地开发各类常见的服务端网络应用程序。本书以muduo 网络库为例，讲解这种编程模型的使用方法及注意事项。', 10);
INSERT INTO `book` VALUES (15, 'C++ Primer 中文版', 'Stanley B. Lippman', 3, '这本久负盛名的 C++经典教程，时隔八年之久，终迎来史无前例的重大升级。除令全球无数程序员从中受益，甚至为之迷醉的——C++ 大师 Stanley B. Lippman 的丰富实践经验，C++标准委员会原负责人 Josée Lajoie 对C++标准的深入理解，以及C++ 先驱 Barbara E. Moo 在 C++教学方面的真知灼见外，更是基于全新的 C++11标准进行了全面而彻底的内容更新。非常难能可贵的是，《C++ Primer 中文版(第5版)》所有示例均全部采用 C++11 标准改写，这在经典升级版中极其罕见——充分体现了 C++ 语言的重大进展及其全面实践。书中丰富的教学辅助内容、醒目的知识点提示，以及精心组织的编程示范，让这本书在 C++ 领域的权威地位更加不可动摇。无论是初学者入门，或是中、高级程序员提升，本书均为不容置疑的首选。', 10);
INSERT INTO `book` VALUES (16, 'Thinking in C++', 'Bruce Eckel', 3, 'In the first edition of Thinking in C++, Bruce Eckel synthesized years of C++ teaching and programming experience into a beautifully structured course in making the most of the language. It became an instant classic, winning the 1995 Software Development Jolt Cola Award for best book of the year. Now, Eckel has thoroughly rewritten Thinking in C++ to reflect the final ANSI/ISO C++ standard. Every page has been revisited and rethought, with many new examples and exercises -- all designed to help you understand C++ \"down to the bare metal,\" so you can solve virtually any problem. Eckel starts with a detailed look at objects, showing how C++ programs can be constructed from off-the-shelf object libraries. This edition includes a new, chapter-length overview of the C features that are used in C++ -- plus a new CD-ROM containing an outstanding C seminar that covers all the foundations developers need before they can truly take advantage of C++. Eckel then walks through initialization and cleanup; function overloading and default arguments; constants; inline functions; name control; references and the copy constructor; operator overloading; and more. There are chapters on dynamic object creation; inheritance and composition; polymorphism and virtual functions, and templates. (Bonus coverage of string, templates, and the Standard Template Library, can be found at Eckel\'s web site.) Every chapter contains many modular, to-the-point examples, plus exercises based on Eckel\'s extensive experience teaching C++ seminars. Put simply, Eckel has made an outstanding book on C++ even better.', 10);
INSERT INTO `book` VALUES (17, '好吗，好的', '大冰', 4, '好吗，好的', 20);
INSERT INTO `book` VALUES (18, '危城', '刘戈', 5, '危城', 10);
INSERT INTO `book` VALUES (19, '我有一个梦', '王鹏', 4, '我有一个梦', 19);
INSERT INTO `book` VALUES (20, '长歌行', '十三君', 5, '长歌行', 102);
INSERT INTO `book` VALUES (21, '天龙八部', '金庸', 5, '乔峰', 27);
INSERT INTO `book` VALUES (22, '神雕侠侣', '金庸', 5, '大雕', 65);
INSERT INTO `book` VALUES (23, 'Vue.js权威指南', '张耀春', 6, 'Vue.js 是一个用来开发Web 界面的前端库。《Vue.js权威指南》致力于普及国内Vue.js 技术体系，让更多喜欢前端的人员了解和学习Vue.js。如果你对Vue.js 基础知识感兴趣，如果你对源码解析感兴趣，如果你对Vue.js 2.0感兴趣，如果你对主流打包工具感兴趣，如果你对如何实践感兴趣，《Vue.js权威指南》都是一本不容错过的以示例代码为引导、知识涵盖全面的最佳选择。《Vue.js权威指南》一共30 章，由浅入深地讲解了Vue.js 基本语法及源码解析。主要内容包括数据绑定、指令、表单控件绑定、过滤器、组件、表单验证、服务通信、路由和视图、vue-cli、测试开发和调试、源码解析及主流打包构建工具等。该书内容全面，讲解细致，示例丰富，适用于各层次的开发者。', 10);
INSERT INTO `book` VALUES (25, 'Java项目开发案例', '明日科技', 1, '《Java项目开发案例全程实录》以进销存管理系统、企业内部通信系统、企业人事管理系统、酒店管理系统、图书馆管理系统、企业快信、欣想电子商城、医药管理系统、企业门户网站、BBS系统、手机网络游戏和棋牌游戏系统之网络五子棋12个实际项目开发程序为案例，从软件工程的角度出发，按照项目的开发顺序，系统、全面地介绍了J2SE、J2EE和J2ME项目的开发流程。从开发背景、需求分析、系统功能分析、数据库分析、数据库建模、网站开发，到网站发布或者程序打包与运行，每一过程都进行了详细的介绍。  《Java项目开发案例全程实录》案例涉及行业广泛，实用性非常强。通过对本书的学习，读者可以了解各个行业的特点，能够针对某一行业进行软件开发，也可以通过光盘中提供的案例源代码和数据库进行二次开发，以减少开发系统所需要的时间。  《Java项目开发案例全程实录》光盘提供12个项目开发完整案例的同步教学视频，12个项目开发完整案例及其源程序，《Java项目开发案例全程实录》的服务网站还提供了内容丰富的素材库、题库、模块库、案例库和本书的答疑服务。本书是一本项目开发案例方面的参考书，适合有基本编程知识但还没有项目开发经验的软件开发初学者使用，尤其适合高校在校生进行毕业设计、课题设计时做参考。', 10);
INSERT INTO `book` VALUES (26, '琉璃美人煞', '十四郎', 7, '十生十世的爱恨情仇', 98);
INSERT INTO `book` VALUES (31, '雪中悍刀行', '屠小意', 5, '雪', 50);
INSERT INTO `book` VALUES (32, '平凡的世界', '路遥', 4, '平凡的世界', 30);
INSERT INTO `book` VALUES (33, '人生', '路遥', 4, '人生', 54);
INSERT INTO `book` VALUES (34, 'C++基础入门', '李白', 3, 'C++', 23);
INSERT INTO `book` VALUES (35, 'Vue高级应用', '刘希杰', 6, 'Vue.js', 21);
INSERT INTO `book` VALUES (36, 'Vue前端框架', '刘蓓蕾', 6, 'Vue.js', 34);
INSERT INTO `book` VALUES (37, '深入学习Vue.js前端知识', '王大力', 6, 'Vue.js入门', 11);
INSERT INTO `book` VALUES (38, 'Vue.js从入门到放弃', '杨柏', 6, 'Vue.js从入门到放弃', 98);
INSERT INTO `book` VALUES (39, '九州缥缈录', '程东', 7, '九州', 43);
INSERT INTO `book` VALUES (40, '海上牧云记', '三歌', 7, '海上牧云记', 56);
INSERT INTO `book` VALUES (41, '仙剑奇侠传', '杨百学', 7, '仙侠', 45);
INSERT INTO `book` VALUES (42, '沉香如屑', '刘戈', 7, '张雪萍', 56);
INSERT INTO `book` VALUES (43, '伏天氏', '净无痕', 8, '伏天', 101);
INSERT INTO `book` VALUES (44, '绝世武神', '净无痕', 8, '净无痕', 50);
INSERT INTO `book` VALUES (45, '完美世界', '辰东', 8, '完美世界', 30);
INSERT INTO `book` VALUES (46, '斗罗大陆', '唐家三少', 8, '唐三', 45);
INSERT INTO `book` VALUES (47, '斗破苍穹', '天蚕土豆', 8, '萧炎', 30);
INSERT INTO `book` VALUES (48, '阿衰', '大头', 9, '阿衰', 32);
INSERT INTO `book` VALUES (49, '呆头', '小头', 9, '大头', 30);
INSERT INTO `book` VALUES (50, '憨豆先生', '憨豆', 9, '憨豆', 50);
INSERT INTO `book` VALUES (51, '武林外传', '唐柏', 9, '武林', 34);
INSERT INTO `book` VALUES (52, '快乐星球', '乐乐', 9, '快乐', 34);
INSERT INTO `book` VALUES (53, '流浪地球', '刘歌', 10, '流浪地球', 29);
INSERT INTO `book` VALUES (54, '变形金刚', '鲍尔', 10, '擎天柱', 45);
INSERT INTO `book` VALUES (55, '莫斯科沦陷', 'King', 10, '莫斯科', 78);
INSERT INTO `book` VALUES (56, '生化危机', 'Tom kaite', 10, '生化危机', 66);
INSERT INTO `book` VALUES (57, '万有引力', '刘凡', 10, '万有引力', 79);

-- ----------------------------
-- Table structure for brrow
-- ----------------------------
DROP TABLE IF EXISTS `brrow`;
CREATE TABLE `brrow`  (
  `ret_check` int(11) NOT NULL DEFAULT 0,
  `add_check` int(11) NOT NULL DEFAULT 0 COMMENT '续借check',
  `brr_check` int(11) NOT NULL DEFAULT 0,
  `book_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `stu_id` int(10) NOT NULL,
  `book_id` int(11) NOT NULL,
  `brrow_date` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `return_date` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `brr_stu_id`(`stu_id`) USING BTREE,
  INDEX `brr_book_id`(`book_id`) USING BTREE,
  CONSTRAINT `brr_book_id` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `brr_stu_id` FOREIGN KEY (`stu_id`) REFERENCES `student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 349 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of brrow
-- ----------------------------
INSERT INTO `brrow` VALUES (2, 0, 2, '廖雪峰Java', 322, 100054, 1, '2021/5/24', '2021/5/24');
INSERT INTO `brrow` VALUES (2, 0, 2, 'Springboot 开源电子书', 323, 100054, 4, '2021/5/25', '2021/5/25');
INSERT INTO `brrow` VALUES (2, 0, 2, 'Java高级应用', 324, 100054, 6, '2021/5/25', '2021/5/25');
INSERT INTO `brrow` VALUES (2, 0, 2, '深入学习Vue.js前端知识', 325, 100054, 37, '2021/5/25', '2021/5/25');
INSERT INTO `brrow` VALUES (2, 0, 2, '好吗，好的', 326, 100054, 17, '2021/5/25', '2021/5/25');
INSERT INTO `brrow` VALUES (2, 2, 2, '我有一个梦', 327, 100054, 19, '2021/5/25', '2021/5/25');
INSERT INTO `brrow` VALUES (2, 0, 2, '人生', 328, 100054, 33, '2021/5/25', '2021/5/25');
INSERT INTO `brrow` VALUES (2, 0, 2, 'c++算法珠玑', 329, 100054, 2, '2021/5/25', '2021/5/25');
INSERT INTO `brrow` VALUES (2, 0, 2, 'Linux多线程服务端编程', 330, 100054, 14, '2021/5/25', '2021/5/25');
INSERT INTO `brrow` VALUES (2, 0, 2, 'C++ Primer 中文版', 331, 100054, 15, '2021/5/25', '2021/5/25');
INSERT INTO `brrow` VALUES (0, 0, 2, 'JAVA核心技术', 332, 100047, 8, '2021/5/24', '2021/6/24');
INSERT INTO `brrow` VALUES (0, 0, 2, '琉璃美人煞', 333, 100044, 26, '2021/5/25', '2021/6/25');
INSERT INTO `brrow` VALUES (0, 0, 2, '阿衰', 334, 100044, 48, '2021/5/25', '2021/6/25');
INSERT INTO `brrow` VALUES (0, 0, 2, '我有一个梦', 335, 100044, 19, '2021/5/25', '2021/6/25');
INSERT INTO `brrow` VALUES (2, 0, 2, '琉璃美人煞', 336, 100042, 26, '2021/5/26', '2021/5/26');
INSERT INTO `brrow` VALUES (2, 0, 2, '仙剑奇侠传', 337, 100042, 41, '2021/5/26', '2021/5/26');
INSERT INTO `brrow` VALUES (2, 0, 2, '快乐星球', 338, 100042, 52, '2021/5/26', '2021/5/26');
INSERT INTO `brrow` VALUES (2, 0, 2, 'Vue.js从入门到放弃', 339, 100054, 38, '2021/5/26', '2021/5/26');
INSERT INTO `brrow` VALUES (2, 0, 2, '海上牧云记', 340, 100054, 40, '2021/5/26', '2021/5/26');
INSERT INTO `brrow` VALUES (2, 0, 2, '伏天氏', 341, 100054, 43, '2021/5/26', '2021/5/26');
INSERT INTO `brrow` VALUES (1, 0, 2, '流浪地球', 342, 100054, 53, '2021/5/26', '2021/6/26');
INSERT INTO `brrow` VALUES (1, 0, 2, '生化危机', 343, 100054, 56, '2021/5/26', '2021/6/26');
INSERT INTO `brrow` VALUES (1, 0, 2, '伏天氏', 344, 100054, 43, '2021/5/26', '2021/6/26');
INSERT INTO `brrow` VALUES (0, 0, 2, '琉璃美人煞', 345, 100054, 26, '2021/5/26', '2021/6/26');
INSERT INTO `brrow` VALUES (0, 0, 2, 'Java高级应用', 346, 100054, 6, '2021/5/26', '2021/6/26');
INSERT INTO `brrow` VALUES (0, 0, 2, '深入理解Java虚拟机', 347, 100054, 7, '2021/5/26', '2021/6/26');
INSERT INTO `brrow` VALUES (0, 0, 2, 'c++算法珠玑', 348, 100042, 2, '2021/5/26', '2021/6/26');

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pwd` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1011 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES (1001, '小刚', '0801', '123456', '13633465455');
INSERT INTO `manager` VALUES (1005, '小白', '0803', '123456', '15353318792');
INSERT INTO `manager` VALUES (1006, '杨过', '0814', '123456', '18798280374');
INSERT INTO `manager` VALUES (1007, '白小飞', '0813', '123456', '19809456798');
INSERT INTO `manager` VALUES (1009, '刘刚', '0819', '123456', '18798084587');
INSERT INTO `manager` VALUES (1010, '小袁', '0117', '123456', '19808234578');

-- ----------------------------
-- Table structure for sort
-- ----------------------------
DROP TABLE IF EXISTS `sort`;
CREATE TABLE `sort`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sort
-- ----------------------------
INSERT INTO `sort` VALUES (1, 'java');
INSERT INTO `sort` VALUES (2, 'python');
INSERT INTO `sort` VALUES (3, 'c++');
INSERT INTO `sort` VALUES (4, '文学');
INSERT INTO `sort` VALUES (5, '武侠');
INSERT INTO `sort` VALUES (6, 'vue');
INSERT INTO `sort` VALUES (7, '仙侠');
INSERT INTO `sort` VALUES (8, '玄幻');
INSERT INTO `sort` VALUES (9, '搞笑');
INSERT INTO `sort` VALUES (10, '科幻');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `time_out` int(1) NOT NULL DEFAULT 0,
  `brr_count` int(11) NOT NULL DEFAULT 10,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pwd` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `card` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100055 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (0, 9, 100042, '李飞', 'mys', 'mayunshen', '1', '17853318792');
INSERT INTO `student` VALUES (0, 10, 100043, '袁小明', 'yinxiao', '123456', '1', '14797346116');
INSERT INTO `student` VALUES (0, 5, 100044, '万青', 'student', '123456', '1', '15435452454');
INSERT INTO `student` VALUES (0, 9, 100046, '追风少年', '980818', '123456', '1', '18789780868');
INSERT INTO `student` VALUES (0, 9, 100047, '柳杨', 'yxd123', '123456', '1', '15552670125');
INSERT INTO `student` VALUES (0, 10, 100048, '白滨', 'yxd12345', '123456', '0', '15552670125');
INSERT INTO `student` VALUES (0, 10, 100049, '杨方', 'yxd1234567', '123456', '0', '15552670126');
INSERT INTO `student` VALUES (0, 10, 100050, '白月初', 'user', '123456', '1', '18803830913');
INSERT INTO `student` VALUES (0, 10, 100053, '晓茗', 'yxm', '920117', '1', '18909875687');
INSERT INTO `student` VALUES (1, 5, 100054, '小白', '081417123', '123456', '1', '18803830914');

SET FOREIGN_KEY_CHECKS = 1;
