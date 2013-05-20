function countCharacters(text, targetID) {
	var count = 140-text.length;
	var text = (count != 1) ? "You have <b>" + count + "</b> characters left" : "You have <b>" + count + "</b> character left"
	document.getElementById(targetID).innerHTML = text;
}