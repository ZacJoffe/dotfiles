# Defined in - @ line 0
function shutdown --description 'alias shutdown sudo shutdown -h now'
	sudo shutdown -h now $argv;
end
