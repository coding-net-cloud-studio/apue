#! /usr/bin/make -f

# 下面一行的定义_对于echo -e模式正确输出是必须的
SHELL=/bin/bash

# NOTE 内部的_LINUX开发机器上的版本_多一个cf_figlinks
# DIRS = lib intro sockets advio daemons datafiles db environ \
# 	fileio filedir ipc1 ipc2 proc pty relation signals standards \
# 	stdio termios threadctl threads printer exercises \
# 	cf_figlinks cg_figlinks ch_figlinks_batch_ai_comment

# NOTE cloudstudio.net等的版本_少了一个cf_figlinks
DIRS = lib intro sockets advio daemons datafiles db environ \
	fileio filedir ipc1 ipc2 proc pty relation signals standards \
	stdio termios threadctl threads printer exercises \
	cg_figlinks ch_figlinks_batch_ai_comment

# -----------------------------------------------------------------------
# 这里是缺省构建目标_只是_展示帮助信息
default: help

# -----------------------------------------------------------------------
# 0_更新到最新版本
0_更新到最新版本:
	-@ [[ -f $$(which cloudstudio) ]] && git stash || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git branch --set-upstream-to=origin/wmstudy_cn wmstudy_cn           || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git switch wmstudy_cn || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git pull origin wmstudy_cn || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git switch cloudstudio_刚刚下拉 || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git pull origin wmstudy_cn || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git switch wmstudy_cn || exit 0

# 这里是 0_更新到最新版本 的便捷方式
0: 0_更新到最新版本
# -----------------------------------------------------------------------

.PHONY : all
all:
	@# wmtag_memo_我修改了这里_开始
	@# 安装了点需要用的软件与库文件
	-@bash ab10_wmscript_init_this.sh
	@# wmtag_memo_我修改了这里_结束
	for i in $(DIRS); do \
		(cd $$i && echo "making $$i" && $(MAKE) ) || exit 1; \
	done
	sudo cp lib/libapue.a /usr/lib

.PHONY : init
# init:
# 	-@ [[ -f $$(which cloudstudio) ]] && git checkout -b cloudstudio_刚刚下拉 || exit 0
# 	-@bash ab10_wmscript_init_this.sh


# NOTE 这里给club增加一个独立的初始化快捷方式
# 这里仅仅安装几个构建apue需要用到的软件与库文件
install_lib_for_club:
	-@ [[ -f $$(which cloudstudio) ]] && echo "cloudstudio 已经安装" || echo "cloudstudio 未安装 无需执行_本目标"
	-@ [[ -f $$(which cloudstudio) ]] && apt update && apt install libbsd-dev || echo "cloudstudio 未安装 无需执行_本目标"

# REVIEW build构建目标被如下的文件所引用 .vscode/tasks.json
# REVIEW 本构建目标,也间接的被.vscode/launch.json所引用_参与到单个c语言源代码的调试过程中去
.PHONY : build
build:
	for i in $(DIRS); do \
		(cd $$i && echo "making $$i" && $(MAKE) ) || exit 1; \
	done
	sudo cp lib/libapue.a /usr/lib

.PHONY : clean
clean:
	for i in $(DIRS); do \
		(cd $$i && echo "cleaning $$i" && $(MAKE) clean) || exit 1; \
	done

# -----------------------------------------------------------------------

# help:
# 	@echo -e "\n"
# 	@echo -e "\033[33m 使用帮助: \033[0m"
# 	@echo -e "\n"
# 	@echo -e "\033[33m 欢迎来到_考研_学习笔记_的世界 \033[0m"
# 	@echo -e "\n"
# 	@echo -e "特别提示: 先输入make 再选择数字 接着按键盘左上角的Tab键 可以自动完成输入"
# 	@echo -e "\t  --这样的方式对于初学者最为简洁^_&"
# 	@echo -e "\t  --资深程序员请忽略本方式"
# 	@echo -e "\n"
# 	@echo -e "make 9_check                                   : 判断是否处于cloudstudio工作空间中"
# 	@echo -e "make 11_install_lib_for_club                   : 本目标只是在club教程中运行_快速安装构建需要用到的几个库"
# 	@echo -e "make 12_init_for_cloudstudio                   : 本目标只是在cloudstudio工作空间中运行_只需要运行1次就可以了"
# 	@echo -e "make 23_build_all                              : 开始干活_构建本_考研_学习笔记_的所有源文件"
# 	@echo -e "make 4_查看构建结果                            : 查看查看_查看是否已经构建出可执行文件"
# 	@echo -e "make 5_show                                    : 用git clean -xdf -n 查看是否已经构建出可执行文件"
# 	@echo -e "make 6_show_executable                         : 用find命令查找已经构建出的可执行文件"
# 	@echo -e "make 7_clean_all                               : 打扫卫生_清除上面构建出来的所有可执行目标文件"
# 	@echo -e "\n\n"
# 	@exit 0

help:
	@echo -e "\n"
	@echo -e "\033[33m Makefile 帮助信息 \033[0m"
	@echo -e "\033[33m 欢迎来到_考研_学习笔记_的世界 \033[0m"
	@echo -e "\n"
	@echo -e "特别提示: 先输入make 再选择数字"
	@echo -e "         接着按键盘左上角的Tab键"
	@echo -e "         可以自动完成输入"
	@echo -e "\t  --这样的方式对于初学者最为简洁^_&"
	@echo -e "\t  --资深程序员请忽略本方式"
	@echo -e "\n"
	@echo -e "0_更新到最新版本"
	@echo -e "  : 与git仓库同步最新内容(首先执行这里)"
	@echo -e "9_check"
	@echo -e "  : 判断是否处于cloudstudio工作空间中"
	@echo -e "11_install_lib_for_club"
	@echo -e "  : 本目标只是在club教程中运行"
	@echo -e "    快速安装构建需要用到的几个库"
	@echo -e "12_init_for_cloudstudio"
	@echo -e "  : 本目标只是在cloudstudio工作空间中运行"
	@echo -e "    只需要运行1次就可以了"
	@echo -e "23_build_all"
	@echo -e "  : 开始干活_构建本_考研_学习笔记_的所有源文件"
	@echo -e "4_查看构建结果"
	@echo -e "  : 查看查看_查看是否已经构建出可执行文件"
	@echo -e "5_show"
	@echo -e "  : 用git clean -xdf -n"
	@echo -e "    查看是否已经构建出可执行文件"
	@echo -e "6_show_executable"
	@echo -e "  : 用find命令查找已经构建出的可执行文件"
	@echo -e "7_clean_all"
	@echo -e "  : 打扫卫生"
	@echo -e "    清除上面构建出来的所有可执行目标文件"
	@echo -e "\n"
	@echo "示例命令:"
	@echo "make: 构建项目"
	@echo "make  7_clean_all"
	@echo "        : 清理生成的文件"
	@echo "make  help"
	@echo "        : 显示此帮助信息"
	@exit 0

# -----------------------------------------------------------------------
# bash - Makefile中的基本if else语句
# https://www.coder.work/article/7542462
.PHONY : 9_check
# REVIEW 9_check 这里是真实的定义
9_check:
	@echo -e "$$(pwd)/Makefile wmtask_[9_check]_目标_被运行\n"
	@if [ $$(which cloudstudio) ]; then \
		echo "位于cloudstudio工作空间中"; \
	else \
		echo "没有处于cloudstudio工作空间中"; \
	fi
	@echo -e "\033[33m 执行本目标完毕,可以执行Next(下一步)目标 \033[0m\n"

# -----------------------------------------------------------------------
.PHONY : 11_install_lib_for_club club
# 下面是别名
11_install_lib_for_club: install_lib_for_club
	-@echo -e "$$(pwd)/Makefile wmtask_[11_install_lib_for_club]_目标_被运行\n"
	-@exit 0

# 下面是别名
club: 11_install_lib_for_club
	-@echo -e "$$(pwd)/Makefile wmtask_[11_install_lib_for_club]_目标_被运行\n"
	-@exit 0

# -----------------------------------------------------------------------

.PHONY : 12_init_for_cloudstudio_main 12_init_for_cloudstudio cs
# 下面是别名
# 12_init_for_cloudstudio: init
# 	-@echo -e "$$(pwd)/Makefile wmtask_[2_init_for_cloudstudio]_目标_被运行\n"
# 	-@ [[ -f $$(which cloudstudio) ]] && git add -A || exit 0
# 	-@ [[ -f $$(which cloudstudio) ]] && git commit -m "进入cloudstudio首次提交" || exit 0
# 	-@ [[ -f $$(which cloudstudio) ]] && git checkout -b cloudstudio_运行中 || exit 0
# 	-@ [[ -f $$(which cloudstudio) ]] && make build || exit 0
# 	-@ [[ -f $$(which cloudstudio) ]] && make help  || exit 0
# 	-@exit 0

# 使用bash执行脚本_安装一下需要用到的软件
12_init_for_cloudstudio_main:
	-@echo -e "$$(pwd)/Makefile wmtask_[12_init_for_cloudstudio]_目标_被运行\n"
	-@ [[ -f $$(which cloudstudio) ]] && git remote remove  origin  || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git remote add     origin https://cnb.cool/8888/c/linux_c.git || exit 0
	@# -@ [[ -f $$(which cloudstudio) ]] && git remote add     cnb    https://cnb.cool/8888/c/linux_c.git || exit 0
	@# -@ [[ -f $$(which cloudstudio) ]] && git remote add     github https://github.com/coding-net-cloud-studio/linux_c.git || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git checkout -b cloudstudio_刚刚下拉 || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && touch README.md
	-@ [[ -f $$(which cloudstudio) ]] && git add -A || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git commit -m "进入cloudstudio首次提交" || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git checkout -b cloudstudio_运行中 || exit 0
	@# -@ [[ -f $$(which cloudstudio) ]] && git branch --set-upstream-to=origin/wmstudy_cn cloudstudio_运行中    || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git branch --set-upstream-to=origin/wmstudy_cn cloudstudio_刚刚下拉  || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git branch --set-upstream-to=origin/wmstudy_cn wmstudy_cn           || exit 0
	-@bash ab10_wmscript_init_this.sh || exit 0
	-@make  23_build_all
	-@clear
	-@make help

12_init_for_cloudstudio: 12_init_for_cloudstudio_main 0_更新到最新版本
	-@clear
	-@make help

# 下面是别名
# cs: init
# 	-@echo -e "$$(pwd)/Makefile wmtask_[2_init_for_cloudstudio]_目标_被运行\n"
# 	-@exit 0

# 快捷名称
cs: 12_init_for_cloudstudio

# -----------------------------------------------------------------------

.PHONY : 23_build_all
# 下面是别名
23_build_all: build
	-@echo -e "$$(pwd)/Makefile wmtask_[23_build_all]_目标_被运行\n"
	-@exit 0

# -----------------------------------------------------------------------
.PHONY : 4_查看构建结果
4_查看构建结果:
	-@echo -e "$$(pwd)/Makefile wmtask_[4_查看构建结果]_目标_被运行\n"
	-@ [[ ! -f $$(which cloudstudio) ]] && git status || exit 0
	-@exit 0

# -----------------------------------------------------------------------
.PHONY : 5_show
5_show:
	-@echo -e "$$(pwd)/Makefile wmtask_[5_show]_目标_被运行\n"
	-@ [[ ! -f $$(which cloudstudio) ]] && git clean -xdf -n || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && find . -type f -executable | grep -v ".vscode" | grep -v ".wmstudy" | grep -v ".sh" | grep -v ".awk" || exit 0
	-@exit 0

# -----------------------------------------------------------------------
# 展示构建的可执行文件列表_排除了shell脚本文件_排除了.o文件_排除了.so文件_排除了awk文件
.PHONY : 6_show_executable
6_show_executable:
	-@echo -e "$$(pwd)/Makefile wmtask_[6_show_executable]_目标_被运行\n"
	-@find . -type f -executable | grep -v vscode | grep -v ".git" | grep -v ".wmstudy" | grep -v ".sh" | grep -v ".so" | grep -v ".awk" || exit 0
	-@echo -e "\n共构建出了如下数目的可执行文件:"
	-@find . -type f -executable | grep -v vscode | grep -v ".git" | grep -v ".wmstudy" | grep -v ".sh" | grep -v ".so" | grep -v ".awk"| wc -l
	-@exit 0

# -----------------------------------------------------------------------

.PHONY : 7_clean_all
7_clean_all: clean
	-@echo -e "$$(pwd)/Makefile wmtask_[7_clean_all]_目标_被运行\n"
	-@ [[ ! -f $$(which cloudstudio) ]] && git clean -xdf -n || exit 0
	-@exit 0

# 下面是一个备用的语句
# -@ [[ ! -f $$(which cloudstudio) ]] && [[ -d ./cf_figlinks/ ]] && cd cf_figlinks/ && find  . -type f -executable -exec rm {} \;

# -----------------------------------------------------------------------