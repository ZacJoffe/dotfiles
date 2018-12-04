# Defined in - @ line 0
function logout --description 'alias logout sudo systemctl restart lightdm'
	sudo systemctl restart lightdm $argv;
end
