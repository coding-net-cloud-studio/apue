 #! /bin/bash

# NOTE 本教程是针对完全的初学者
# NOTE 本教程是针对"泛开发者"
# NOTE 泛开发者是指:在本职工作领域是专业人士,但不以编程作为谋生手段
# NOTE 本教程不适合初级程序员_初级程序员应该去看更深的教程了_不需要看本教程
	# NOTE 向已经是程序员的群体,深度推荐:白明,柴树杉,丁尔男,史斌,郝林,徐秋华,陈剑煜,刘丹冰,廖显东,郭宏志,湖南长沙老郭(Nick),王中阳,申专等老师与专家的专业课程
# NOTE 所有曾经编写过300行代码的人士_都不适合看本初级教程了_应该去看其他更深的教程了
# NOTE Makefile中是支持utf-8(unicode)作为目标名称的_我们这样写的目的是给"泛开发者"在初期容易理解实行的
# NOTE 在后继的课程中_我们将取消这些方法_回归到_英文目标名的传统方式
# NOTE 在bash shell script脚本中_针对_泛开发者_我们使用很长的函数名称这样的_非传统方式
# NOTE 在后继的课程中_我们将取消上述_长函数名的_非传统方式_回归常规写法

 # (leading space required for Xenix /bin/sh)

#
# Determine the type of *ix operating system that we're
# running on, and echo an appropriate value.
# This script is intended to be used in Makefiles.
# (This is a kludge.  Gotta be a better way.)
#

pause_60_second(){
	if read -t 60 -p "暂停60秒,按回车继续运行: "
	then
		# echo "hello $REPLY,welcome to cheng du"
		printf "\n";
	else
		# echo "sorry, Output timeout, please execute the command again !"
		printf "\n时间已到,继续运行\n";
	fi
}

# 在cloudstudio环境中_更新_vscode的_用户_settings_文件
# 主要是设置cloud studio为"永不休眠"
f16_cs_vs_settings_user_update(){
	# cloud studio中用户设置文件
	CS_VSCODE_SETTINGS_USER=/root/.local/share/code-server/data/User/settings.json
	# -----------------------------------------------------------
	# '嵌入文档涵盖了生成脚本的主体部分.

	(
	cat <<'EOF'
{
	"cloudstudio.autosleep": "no",
	"go.toolsManagement.autoUpdate": true,
	"redhat.telemetry.enabled": false,
	"bookmarks.saveBookmarksInProject": true,
	"Codegeex.Privacy": true,
	"Codegeex.Survey": false,
	"Codegeex.EnableExtension": true,
	"Codegeex.Explanation.LanguagePreference": "zh-CN",
	"CS.CodeAssistant.EnableExtension": false,
}
EOF
	) > ${CS_VSCODE_SETTINGS_USER}

}

f20_linux_git_setting() {

	git config --global user.email "cloudstudio_my_study@qq.com"

  	git config --global user.name "cloudstudio_my_study"

	#在Linux操作系统环境下
	# git status中文显示乱码解决:
	# https://www.cnblogs.com/v5captain/p/14832597.html
	#相当于在~/.gitconfig 文件中加入一行 file:/root/.gitconfig   core.quotepath=false
	# core.quotepath=false
	git config --global core.quotepath false
	git config --global --add safe.directory $(pwd)

	# 来自廖雪峰的git教程
	# https://www.liaoxuefeng.com/wiki/896043488029600/898732837407424
	git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

	git config --global alias.count "rev-list --all --count"

	git config --global alias.show-graph "log --graph --abbrev-commit --pretty=oneline"
	git config --global alias.sg "log --graph --abbrev-commit --pretty=oneline"
	git config --global alias.st "status -s"
	git config --global alias.last "diff-tree --no-commit-id --name-only -r HEAD~1"
	git config --global alias.gt "status -s"

}


# 在cloudstudio中快速的安装某几个vscode的扩展
f27_38_install_some_vs_ext_quick(){
	echo -e "\n-------在cloudstudio中快速的安装某几个vscode的扩展-------\n"

	[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  formulahendry.code-runner         --force
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  AMiner.codegeex                   --force
	[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  alefragnani.Bookmarks             --force
	[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  ExodiusStudios.comment-anchors    --force
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  ritwickdey.LiveServer             --force
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  ms-azuretools.vscode-docker       --force
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  cweijan.vscode-office             --force
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  arcanis.vscode-zipfs              --force
	[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  mads-hartmann.bash-ide-vscode     --force
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  vsls-contrib.codetour             --force

	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  golang.go                         --force
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  egomobile.vscode-powertools       --force
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  maelvalais.autoconf               --force

	[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  Sycl.markdown-command-runner      --force
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  CloudStudio.tutorialkit           --force

	# NOTE 下面是应对cloudstudio最近把all in one工作空间中所有的vscode扩展都删掉带来的问题_增加的部分
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  ms-python.python   					--force

	# NOTE 这里是为了apue,linux_c等增加的cpp的扩展(ms-cpptools好像是没有发挥作用_原因未知)
	[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  llvm-vs-code-extensions.vscode-clangd --force


	# 下面的来自openvsx社区的jupyter破裂了只能手工的安装
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  ms-toolsai.jupyter   					--force
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  ms-toolsai.jupyter-keymap   			--force
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  ms-toolsai.jupyter-renderers   		--force
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  ms-toolsai.vscode-jupyter-cell-tags   --force
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  ms-toolsai.vscode-jupyter-slideshow   --force

	# 下面的无法通过插件市场简单的安装上去了
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  ms-vscode.cpptools                 --force
	# 代替为如下的简单方法

	if [[ -f $(which cloudstudio) ]]; then
		# 安装c与c++的调试vscode扩展
		# 位置大体类似 .vscode/ext01_ms-vscode.cpptools-1.17.5_linux-x64.vsix
		if [[ $(find .vscode/ -name '*ms-vscode.cpptools*.vsix'| wc -l) -gt 0 ]]; then
			# 提取出ms-vscode.cpptools扩展的文件名称
			wmvar26_10_code_runner_file_name=$(basename $(find .vscode/ -name '*ms-vscode.cpptools*.vsix'| sort -V | tail -n 2 | head -n 1))
			# 判断是否是cloudstudio的环境
			[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension $(pwd)/.vscode/${wmvar26_10_code_runner_file_name} --force
		else
			echo "没有找到随着本git仓库携带的_ms-vscode.cpptools_扩展"
		fi

		# 安装中文标点符号转英文标点符号的vscode扩展
		# 位置大体类似 .vscode/ext06_buuug7.chinese-punctuation-to-english-1.1.0.vsix
		if [[ $(find .vscode/ -name '*buuug7.chinese-punctuation*.vsix'| wc -l) -gt 0 ]]; then
			# 提取出buuug7.chinese-punctuation扩展的文件名称
			wmvar26_20_code_runner_file_name=$(basename $(find .vscode/ -name '*buuug7.chinese-punctuation*.vsix'| sort -V | tail -n 2 | head -n 1))
			# 判断是否是cloudstudio的环境
			[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension $(pwd)/.vscode/${wmvar26_20_code_runner_file_name} --force
		else
			echo "没有找到随着本git仓库携带的_buuug7.chinese-punctuation_扩展"
		fi

		# 安装ut8变量与函数名的_中文输入助手_vscode扩展_是_吴烜(xuan三声)领导下开源的vscode扩展
		# 属于中文代码快速补全
		# 开源的git仓库地址如下 https://gitee.com/Program-in-Chinese/vscode_Chinese_Input_Assistant.git
		# 位置大体类似 .vscode/ext10_v010510_CodeInChinese.ChineseInputAssistant-1.5.10.vsix
		if [[ $(find .vscode/ -name '*CodeInChinese.ChineseInputAssistant*.vsix'| wc -l) -gt 0 ]]; then
			# 提取出CodeInChinese.ChineseInputAssistant扩展的文件名称
			wmvar26_30_code_runner_file_name=$(basename $(find .vscode/ -name '*CodeInChinese.ChineseInputAssistant*.vsix'| sort -V | tail -n 2 | head -n 1))
			# 判断是否是cloudstudio的环境
			[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension $(pwd)/.vscode/${wmvar26_30_code_runner_file_name} --force
		else
			echo "没有找到随着本git仓库携带的_CodeInChinese.ChineseInputAssistant_扩展"
		fi

		# 安装presentation-buddy用于协助codetour等控制学习笔记的演示过程
		# https://marketplace.visualstudio.com/items?itemName=mauricedebeijer.presentation-buddy
		# 位置大体类似 .vscode/ext22_mauricedebeijer.presentation-buddy-0.11.0.vsix
		if [[ $(find .vscode/ -name '*mauricedebeijer.presentation-buddy*.vsix'| wc -l) -gt 0 ]]; then
			# 提取出mauricedebeijer.presentation-buddy扩展的文件名称
			wmvar26_20_code_runner_file_name=$(basename $(find .vscode/ -name '*mauricedebeijer.presentation-buddy*.vsix'| sort -V | tail -n 2 | head -n 1))
			# 判断是否是cloudstudio的环境
			[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension $(pwd)/.vscode/${wmvar26_20_code_runner_file_name} --force
		else
			echo "没有找到随着本git仓库携带的_mauricedebeijer.presentation-buddy_扩展"
		fi

		# 安装数据分析所用的jupyter_notebook的vscode扩展
		# 位置大体类似 .vscode/ext26_ms-toolsai.jupyter-2023.5.1101742258.vsix
		if [[ $(find .vscode/ -name '*ms-toolsai.jupyter*.vsix'| wc -l) -gt 0 ]]; then
			# 提取出ms-toolsai.jupyter扩展的文件名称
			wmvar26_20_code_runner_file_name=$(basename $(find .vscode/ -name '*ms-toolsai.jupyter*.vsix'| sort -V | tail -n 2 | head -n 1))
			# 判断是否是cloudstudio的环境
			[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension $(pwd)/.vscode/${wmvar26_20_code_runner_file_name} --force
		else
			echo "没有找到随着本git仓库携带的_ms-toolsai.jupyter_扩展"
		fi

		# 安装command-alias用于获得vscode内部与扩展的命令的全名
		# https://marketplace.visualstudio.com/items?itemName=ArturoDent.command-alias
		# 位置大体类似 .vscode/ext37_ArturoDent.command-alias-0.6.0.vsix
		if [[ $(find .vscode/ -name '*ArturoDent.command-alias*.vsix'| wc -l) -gt 0 ]]; then
			# 提取出ArturoDent.command-alias扩展的文件名称
			wmvar26_20_code_runner_file_name=$(basename $(find .vscode/ -name '*ArturoDent.command-alias*.vsix'| sort -V | tail -n 2 | head -n 1))
			# 判断是否是cloudstudio的环境
			[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension $(pwd)/.vscode/${wmvar26_20_code_runner_file_name} --force
		else
			echo "没有找到随着本git仓库携带的_ArturoDent.command-alias_扩展"
		fi

		# 安装cloudstudio.browser-preview-lite-club用于获得cloudstudio club的课程能力
		# https://open-vsx.org/extension/cloudstudio/browser-preview-lite-club
		# 位置大体类似 .vscode/wd47_cloudstudio.browser-preview-lite-club-0.0.25.vsix
		if [[ $(find .vscode/ -name '*cloudstudio.browser-preview-lite-club*.vsix'| wc -l) -gt 0 ]]; then
			# 提取出cloudstudio.browser-preview-lite-club扩展的文件名称
			wmvar26_20_code_runner_file_name=$(basename $(find .vscode/ -name '*cloudstudio.browser-preview-lite-club*.vsix'| sort -V | tail -n 2 | head -n 1))
			# 判断是否是cloudstudio的环境
			[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension $(pwd)/.vscode/${wmvar26_20_code_runner_file_name} --force
		else
			echo "没有找到随着本git仓库携带的_cloudstudio.browser-preview-lite-club_扩展"
		fi

		# 安装cloudstudio.workspace-club用于获得cloudstudio club的课程能力
		# https://open-vsx.org/extension/cloudstudio/workspace-club
		# 位置大体类似 .vscode/wg55_cloudstudio.workspace-club-0.0.50.vsix
		if [[ $(find .vscode/ -name '*cloudstudio.workspace-club*.vsix'| wc -l) -gt 0 ]]; then
			# 提取出cloudstudio.workspace-club扩展的文件名称
			wmvar26_20_code_runner_file_name=$(basename $(find .vscode/ -name '*cloudstudio.workspace-club*.vsix'| sort -V | tail -n 2 | head -n 1))
			# 判断是否是cloudstudio的环境
			[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension $(pwd)/.vscode/${wmvar26_20_code_runner_file_name} --force
		else
			echo "没有找到随着本git仓库携带的_cloudstudio.workspace-club_扩展"
		fi

	fi

	# 下面的扩展与ms-vscode.cpptools在调试的时候冲突_不要安装
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  llvm-vs-code-extensions.vscode-clangd --force

	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  ms-vscode.cmake-tools               --force
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  twxs.cmake                          --force

	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  Fr43nk.seito-openfile             --force

	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  cweijan.vscode-mysql-client2      --force
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  cweijan.vscode-database-client2   --force

	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  mkhl.direnv                       --force

	return 0
}

# 安装一些ubuntu环境下的_需要用到的_软件
f33_install_common_software_quick(){
	if [[ -f $(which cloudstudio) ]]; then
		if [[ ! -f $(which wc24_cc28_cloudstudio_installed.sh) ]]; then
			apt update -y
			DEBIAN_FRONTEND='noninteractive' apt install -y \
				iputils-ping \
				sudo \
				make \
				tree \
				curl \
				lsof \
				net-tools \
				psmisc \
				file \
				lsof \
				htop \
				direnv \
				rsync \
				curl \
				direnv \
				sqlite3 \
				libsqlite3-dev \
				sshfs \
				jq \
				aria2 \
				lynx \
				hugo \
				flex \
				jq \
				gron \
				pdfgrep \
				ripgrep \
				httpie \
				pv \
				tree \
				gdb \
				gdbserver \
				bison \
				nasm \
				bear \
				strace

			# NOTE 执行完成安装任务以后_创建_锁文件
			echo "echo 已经初始化了本cloudstudio工作空间 $(date)" >> /usr/bin/wc24_cc28_cloudstudio_installed.sh
			chmod +x /usr/bin/wc24_cc28_cloudstudio_installed.sh
		fi

	fi

	return 0

# DEBIAN_FRONTEND='noninteractive' apt install -y rkhunter unhide sshpass

}

f36_install_gcc_10_versioin(){

	apt install -y gcc-10
	apt install -y g++-10

	[ -f /usr/bin/gcc-9 ]  && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 120
	[ -f /usr/bin/gcc-10 ] && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 150
	[ -f /usr/bin/g++-9 ]  && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 120
	[ -f /usr/bin/g++-10 ] && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 150

}


#==================================================================================================

# 安装一些apue_3e构建_需要的软件_主要是libbsd-dev
l37_apue_3e_install_some_software(){

	DEBIAN_FRONTEND='noninteractive' apt install -y \
			libbsd-dev
	return 0
}

# 把apue_3e的几个文件拷贝到需要的位置
l39_apue_3e_copy_some_files(){
	cp include/apue.h /usr/include/
	cp lib/error.c /usr/include/
}

# 把apue_3e的几个文件shell与awk文件确认变为可执行
l42_apue_3e_chmod_some_files(){

	find . -name "*.sh" -exec chmod +x {} \;
	find . -name "*.awk" -exec chmod +x {} \;

}

# 在腾云扣钉的cloudstudio工作空间中执行如下的函数
f92_main_cloudstudio(){

	export WMVAR_ALL_OLD_PWD=$(pwd)

	# 在cloudstudio环境中_更新_vscode的_用户_settings_文件
	# 主要是设置cloud studio为"永不休眠"
	f16_cs_vs_settings_user_update

	# 设置一下git的配置
	f20_linux_git_setting

	# 返回原始的目录
	cd ${WMVAR_ALL_OLD_PWD}

	# 在cloudstudio中快速的安装某几个vscode的扩展
	f27_38_install_some_vs_ext_quick

	cd ${WMVAR_ALL_OLD_PWD}

	# 安装一些ubuntu环境下的_需要用到的_软件
	f33_install_common_software_quick
	f36_install_gcc_10_versioin

	# 返回原始的目录
	cd ${WMVAR_ALL_OLD_PWD}

	# 安装一些apue_3e构建_需要的软件_主要是libbsd-dev
	l37_apue_3e_install_some_software

	# 返回原始的目录
	cd ${WMVAR_ALL_OLD_PWD}

	# 把apue_3e的几个文件拷贝到需要的位置
	l39_apue_3e_copy_some_files

	# 把apue_3e的几个文件shell与awk文件确认变为可执行
	l42_apue_3e_chmod_some_files

	cd ${WMVAR_ALL_OLD_PWD}

	export WMTAG_LOCK_FILE=~/w26.c10_41_38_cloud_studio_apue_3e_已经存在锁文件了_运行标记文件-wmgitignore.wmtag_lock.sh
	echo -e "已经存在锁文件了_不再进行任何动作_1020" > ${WMTAG_LOCK_FILE}
	echo -e "\n运行在 $(pwd)/${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]} 脚本的 ${FUNCNAME} 函数中 ${LINENO} 行\n" >> ${WMTAG_LOCK_FILE}
	date '+%Y-%m-%d 日 %H:%M:%S 秒' >> ${WMTAG_LOCK_FILE}
	chmod +x ${WMTAG_LOCK_FILE}

	return 0
}

all(){

	# 锁文件的名称与位置
	local WMTAG_LOCK_FILE=~/w26.c10_41_38_cloud_studio_apue_3e_已经存在锁文件了_运行标记文件-wmgitignore.wmtag_lock.sh

	# 判断位于cloudstudio的工作空间中才会执行
	if [[ -f $(which cloudstudio) ]]; then
		# 在腾云扣钉的cloudstudio工作空间中

		# 判断是否已经执行过至少1次
		if [[ ! -f ${WMTAG_LOCK_FILE} ]]; then
			# 不存在锁文件_才会执行
			f92_main_cloudstudio
		else
			# 执行过了_就不再执行了
			echo "已经执行过一次了_不会再次执行_cloudstudio工作空间中_apue_3e的初始化"
		fi
	else
		echo "没有处于cloudstudio工作空间中_不需要执行"
	fi

	return 0
}

# 最终执行的进入地点在这里
all
