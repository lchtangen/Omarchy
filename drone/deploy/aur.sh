#!/usr/bin/env bash
set -euo pipefail
# AUR package deploy — publish extracted theme collection as AUR package

PKGNAME="${1:-omarchy-themes-collection}"
AUR_DIR="/tmp/aur-$PKGNAME"
VERSION=$(date +%Y.%m.%d)

echo "=== Drone Deploy: $PKGNAME v$VERSION ==="

# Create PKGBUILD
mkdir -p "$AUR_DIR"
cat > "$AUR_DIR/PKGBUILD" <<EOF
# Maintainer: Omarchy Drone <drone@omarchy.local>
pkgname=$PKGNAME
pkgver=$VERSION
pkgrel=1
pkgdesc="Collection of extracted Omarchy themes from top-starred repos"
arch=('any')
license=('MIT')
source=("\$pkgname-\$pkgver.tar.gz")
sha256sums=('SKIP')

package() {
  install -dm755 "\$pkgdir/usr/share/omarchy/themes"
  cp -r dist/themes/* "\$pkgdir/usr/share/omarchy/themes/"
}
EOF

echo "PKGBUILD generated at $AUR_DIR"
echo "Deploy: cd $AUR_DIR && makepkg --printsrcinfo > .SRCINFO && git push aur"
