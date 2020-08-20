export BUILD_DIRECTORY=`pwd`/_build/html/
make clean html
rm -rf /tmp/drunkenoctop.us
git clone git@github.com:jcustenborder/drunkenoctop.us.git /tmp/drunkenoctop.us
cd /tmp/drunkenoctop.us
git checkout gh-pages
cp -rv ${BUILD_DIRECTORY} .
git add .
git commit . -m 'Docs update'
git push
