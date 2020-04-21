# Definition of functions .....................................................................

# IMAGE.SCALE
# This function creates a color scale for use with the image() function. 
# Input parameters should be consistent with those used in the corresponding image plot. 
# The "horiz" argument defines whether the scale is horizonal(=TRUE) or vertical(=FALSE).
image.scale <- function(z, zlim, col = rainbow(12), breaks, horiz=TRUE, ...){
  if(!missing(breaks)){
    if(length(breaks) != (length(col)+1)){stop("must have one more break than colour")}
  }
  if(missing(breaks) & !missing(zlim)){
    breaks <- seq(zlim[1], zlim[2], length.out=(length(col)+1)) 
  }
  if(missing(breaks) & missing(zlim)){
    zlim <- range(z, na.rm=TRUE)
    zlim[2] <- zlim[2]+c(zlim[2]-zlim[1])*(1E-3)#adds a bit to the range in both directions
    zlim[1] <- zlim[1]-c(zlim[2]-zlim[1])*(1E-3)
    breaks <- seq(zlim[1], zlim[2], length.out=(length(col)+1))
  }
  poly <- vector(mode="list", length(col))
  for(i in seq(poly)){
    poly[[i]] <- c(breaks[i], breaks[i+1], breaks[i+1], breaks[i])
  }
  xaxt <- ifelse(horiz, "s", "n")
  yaxt <- ifelse(horiz, "n", "s")
  if(horiz){ylim<-c(0,1); xlim<-range(breaks)}
  if(!horiz){ylim<-range(breaks); xlim<-c(0,1)}
  plot(1,1,t="n",ylim=ylim, xlim=xlim, xaxt=xaxt, yaxt=yaxt, xaxs="i", yaxs="i", ...)  
  for(i in seq(poly)){
    if(horiz){
      polygon(poly[[i]], c(0,0,1,1), col=col[i], border=NA)
    }
    if(!horiz){
      polygon(c(0,0,1,1), poly[[i]], col=col[i], border=NA)
    }
  }
}


# EXPHET
# computes the expected heterozygosity for a given site
# INPUT:
#   geno_site : vector of size nind with the genotypes coded as 0,1,2 and NA (missing data)
# OUTPUT:
#   expected heterozygosity
ExpHet <- function(geno_site) {
  
  # get the number of individuals with data
  ngenecopies <- 2*sum(!is.na(geno_site))
  
  # get the frequency of the alternative allele
  freq <- sum(geno_site, na.rm=T)/ngenecopies
  
  # output the expected heterozygosity
  he <- (ngenecopies/(ngenecopies-1))*2*freq*(1-freq)
  he
}

