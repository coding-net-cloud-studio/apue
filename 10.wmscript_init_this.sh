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

	return 0
}

f33_install_common_software_quick(){

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
		make 
}

l35_apue_3e_install_some_software(){
		DEBIAN_FRONTEND='noninteractive' apt install -y \
			libbsd-dev
}

l39_apue_3e_copy_some_files(){
	cp include/apue.h /usr/include/
	cp lib/error.c /usr/include/ 
}


all(){

	export WMVAR_ALL_OLD_PWD=$(pwd)

	# 在cloudstudio环境中_更新_vscode的_用户_settings_文件
	# 主要是设置cloud studio为"永不休眠"
	f16_cs_vs_settings_user_update

	# 返回原始的目录
	cd ${WMVAR_ALL_OLD_PWD}

	# 在cloudstudio中快速的安装某几个vscode的扩展
	f27_38_install_some_vs_ext_quick

	cd ${WMVAR_ALL_OLD_PWD}

	f33_install_common_software_quick

	# 返回原始的目录
	cd ${WMVAR_ALL_OLD_PWD}

	# 进行环境整理工作
	l35_apue_3e_install_some_software

	# 返回原始的目录
	cd ${WMVAR_ALL_OLD_PWD}

	l39_apue_3e_copy_some_files

	cd ${WMVAR_ALL_OLD_PWD}

	return 0
}

# 最终执行的进入地点在这里
all
