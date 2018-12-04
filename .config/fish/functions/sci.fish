# Defined in - @ line 0
function sci --description alias\ sci\ maim\ -s\ /tmp/screenshot.png\;\ bash\ \~/Documents/Code/Shell/Imgur\\\ Uploader/uploader.sh\ /tmp/screenshot.png\ \|\ xclip\ -selection\ clipboard
	maim -s /tmp/screenshot.png; bash ~/Documents/Code/Shell/Imgur\ Uploader/uploader.sh /tmp/screenshot.png | xclip -selection clipboard $argv;
end
