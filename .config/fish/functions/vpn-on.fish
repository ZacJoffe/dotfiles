# Defined in - @ line 1
function vpn-on --description 'alias vpn-on=wg-quick up mullvad-us13'
	wg-quick up mullvad-us13 $argv;
end
