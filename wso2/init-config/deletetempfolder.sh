HOME=`$(bash <<< "echo ~${SUDO_USER:-}")`
echo "Path of Temp folder :$HOME"
rm -r -f $HOME/.wso2apictl
rm -r -f  PetStore/
