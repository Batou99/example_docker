#/bin/sh
if [ ! -f .ssh/id_rsa.pub ] && [ ! -f .ssh/id_rsa ]; then
  echo "Keys not found! Add your rsa keys to the .ssh folder"
  exit 0
fi

# Change this for the code you want in the container
git clone git@github.com:Batou99/dotfiles.git code
docker build -t batou99/my-container .
rm -rf code
