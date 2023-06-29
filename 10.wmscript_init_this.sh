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
	"Codegeex.EnableExtension": false,
	"CS.CodeAssistant.EnableExtension": false,
}
EOF
	) > ${CS_VSCODE_SETTINGS_USER}

}

f20_linux_git_setting() {
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

}


# 在cloudstudio中快速的安装某几个vscode的扩展
f27_38_install_some_vs_ext_quick(){
	echo -e "\n-------在cloudstudio中快速的安装某几个vscode的扩展-------\n"

	[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  formulahendry.code-runner         --force
	[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  AMiner.codegeex                   --force
	[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  alefragnani.Bookmarks             --force
	[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  ExodiusStudios.comment-anchors    --force
	[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  ritwickdey.LiveServer             --force
	[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  ms-azuretools.vscode-docker       --force
	[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  cweijan.vscode-office             --force
	[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  arcanis.vscode-zipfs              --force
	[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  mads-hartmann.bash-ide-vscode     --force
	[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  vsls-contrib.codetour             --force

	[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  ms-vscode.cpptools                 --force
	[[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  llvm-vs-code-extensions.vscode-clangd --force

	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  ms-vscode.cmake-tools               --force
	# [[ -f $(which cloudstudio) ]] && cloudstudio --install-extension  twxs.cmake                          --force

	return 0
}

# 安装一些ubuntu环境下的_需要用到的_软件
f33_install_common_software_quick(){

	apt update

	DEBIAN_FRONTEND='noninteractive' apt install -y \
		sudo \
		tree \
		curl \
		net-tools \
		lsof \
		htop \
		direnv \
		rsync \
		sshfs \
		jq \
		aria2 \
		lynx \
		hugo \
		flex \
		make \
		gdb \
		bison \
		nasm \
		bear \
		strace 
	
		# DEBIAN_FRONTEND='noninteractive' apt install -y rkhunter unhide sshpass
	
	return 0
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

# 在腾云扣钉的cloudstudio工作空间中执行如下的函数
f92_main_cloudstudio(){

	export WMVAR_ALL_OLD_PWD=$(pwd)

	# 在cloudstudio环境中_更新_vscode的_用户_settings_文件
	# 主要是设置cloud studio为"永不休眠"
	f16_cs_vs_settings_user_update

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
