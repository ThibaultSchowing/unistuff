
# Simple function to convert a string of characters into a vector of character
convertStringToCharVector=function(curString) {
  return(strsplit(curString, split="")[[1]])
}
