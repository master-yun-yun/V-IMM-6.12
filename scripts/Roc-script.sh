# 修改默认IP & 固件名称 & 编译署名
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
sed -i "s/hostname='.*'/hostname='Roc'/g" package/base-files/files/bin/config_generate
sed -i "s/(\(luciversion || ''\))/(\1) + (' \/ Build by Roc')/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js

# 移除要替换的包
rm -rf feeds/packages/net/alist
rm -rf feeds/luci/applications/luci-app-alist
rm -rf feeds/packages/net/open-app-filter
rm -rf package/emortal/luci-app-athena-led

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# AList & AdGuardHome & WolPlus & Lucky & OpenAppFilter & 集客无线AC控制器 & 雅典娜LED控制
git clone --depth=1 https://github.com/sbwml/luci-app-alist package/luci-app-alist
git_sparse_clone master https://github.com/kenzok8/openwrt-packages luci-app-adguardhome
git_sparse_clone main https://github.com/VIKINGYFY/packages luci-app-wolplus
git clone --depth=1 https://github.com/gdy666/luci-app-lucky package/luci-app-lucky
git clone --depth=1 https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
git clone --depth=1 https://github.com/lwb1978/openwrt-gecoosac package/openwrt-gecoosac
git clone --depth=1 https://github.com/NONGFAH/luci-app-athena-led package/luci-app-athena-led
chmod +x package/luci-app-athena-led/root/etc/init.d/athena_led package/luci-app-athena-led/root/usr/sbin/athena-led

#------------------以下自定义源（须验证 -b main 或 -b master 是否需要）--------------------#

#全能推送PushBot----OK
UPDATE_PACKAGE "luci-app-pushbot" "zzsj0928/luci-app-pushbot" "master"
git clone --depth=1 -b master https://github.com/zzsj0928/luci-app-pushbot package/luci-app-pushbot

#关机poweroff----OK
UPDATE_PACKAGE "luci-app-poweroff" "DongyangHu/luci-app-poweroff" "main"
git clone --depth=1 -b main https://github.com/DongyangHu/luci-app-poweroff package/luci-app-poweroff

#主题界面edge----OK
UPDATE_PACKAGE "luci-theme-edge" "ricemices/luci-theme-edge" "master"
git clone --depth=1 -b master https://github.com/ricemices/luci-theme-edge package/luci-theme-edge

#分区扩容----OK
UPDATE_PACKAGE "luci-app-partexp" "sirpdboy/luci-app-partexp" "main"
git clone --depth=1 -b main https://github.com/sirpdboy/luci-app-partexp package/luci-app-partexp

#阿里云盘aliyundrive-webdav----OK
UPDATE_PACKAGE "luci-app-aliyundrive-webdav" "messense/aliyundrive-webdav" "main"
git clone --depth=1 -b main https://github.com/messense/aliyundrive-webdav package/luci-app-aliyundrive-webdav

#服务器
#UPDATE_PACKAGE "luci-app-openvpn-server" "hyperlook/luci-app-openvpn-server" "main"
#UPDATE_PACKAGE "luci-app-openvpn-server" "ixiaan/luci-app-openvpn-server" "main"

#luci-app-navidrome音乐服务器----OK
#UPDATE_PACKAGE "luci-app-navidrome" "tty228/luci-app-navidrome" "main"
git clone --depth=1 -b main https://github.com/tty228/luci-app-navidrome package/luci-app-navidrome

#端口转发luci-app-socat----OK
#UPDATE_PACKAGE "luci-app-socat" "WROIATE/luci-app-socat" "main"
git clone --depth=1 -b main https://github.com/WROIATE/luci-app-socat package/luci-app-socat

#------------------以上自定义源--------------------#


#-------------------2025.05.25测试（须验证 -b main 或 -b master 或 -b Immortalwrt 是否需要）----------------#
#UPDATE_PACKAGE "luci-app-clouddrive2" "shidahuilang/openwrt-package" "Immortalwrt" "pkg"

#UPDATE_PACKAGE "istoreenhance" "shidahuilang/openwrt-package" "Immortalwrt" "pkg"
git_sparse_clone -b Immortalwrt https://github.com/shidahuilang/openwrt-package istoreenhance
#UPDATE_PACKAGE "luci-app-istoreenhance" "shidahuilang/openwrt-package" "Immortalwrt" "pkg"
git_sparse_clone -b Immortalwrt https://github.com/shidahuilang/openwrt-package luci-app-istoreenhance

#UPDATE_PACKAGE "linkmount" "shidahuilang/openwrt-package" "Immortalwrt" "pkg"
git_sparse_clone -b Immortalwrt https://github.com/shidahuilang/openwrt-package linkmount
#UPDATE_PACKAGE "linkease" "shidahuilang/openwrt-package" "Immortalwrt" "pkg"
git_sparse_clone -b Immortalwrt https://github.com/shidahuilang/openwrt-package linkease
#UPDATE_PACKAGE "luci-app-linkease" "shidahuilang/openwrt-package" "Immortalwrt" "pkg"
git_sparse_clone -b Immortalwrt https://github.com/shidahuilang/openwrt-package luci-app-linkease


#UPDATE_PACKAGE "quickstart" "master-yun-yun/package-istore" "Immortalwrt" "pkg"
git_sparse_clone -b Immortalwrt https://github.com/"master-yun-yun/package-istore quickstart
#UPDATE_PACKAGE "luci-app-quickstart" "master-yun-yun/package-istore" "Immortalwrt" "pkg"
git_sparse_clone -b Immortalwrt https://github.com/"master-yun-yun/package-istore luci-app-quickstart

#UPDATE_PACKAGE "luci-app-store" "shidahuilang/openwrt-package" "Immortalwrt" "pkg"
git_sparse_clone -b Immortalwrt https://github.com/shidahuilang/openwrt-package luci-app-store

#UPDATE_PACKAGE "webdav2" "shidahuilang/openwrt-package" "Immortalwrt" "pkg"
git_sparse_clone -b Immortalwrt https://github.com/shidahuilang/openwrt-package webdav2
#UPDATE_PACKAGE "unishare" "shidahuilang/openwrt-package" "Immortalwrt" "pkg"
git_sparse_clone -b Immortalwrt https://github.com/shidahuilang/openwrt-package unishare
#UPDATE_PACKAGE "luci-app-unishare" "shidahuilang/openwrt-package" "Immortalwrt" "pkg"
git_sparse_clone -b Immortalwrt https://github.com/shidahuilang/openwrt-package luci-app-unishare

#luci-app-athena-led-雅典娜led屏幕显示（默认已有）
#UPDATE_PACKAGE "luci-app-athena-led" "NONGFAH/luci-app-athena-led" "main"
#git clone --depth=1 -b main https://github.com/NONGFAH/luci-app-athena-led package/luci-app-athena-led
#chmod +x package/luci-app-athena-led/root/etc/init.d/athena_led package/luci-app-athena-led/root/usr/sbin/athena-led

#-------------------2025.05.25-测试-----------------#

./scripts/feeds update -a
./scripts/feeds install -a
