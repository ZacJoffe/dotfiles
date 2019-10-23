# Defined in - @ line 1
function vpn-off --description 'alias vpn-off=wg-quick down mullvad-us13'
	wg-quick down mullvad-us13 $argv;
end
