# Defined in - @ line 0
function sc --description 'alias sc maim -s | xclip -selection clipboard -t image/png'
	maim -s | xclip -selection clipboard -t image/png $argv;
end
