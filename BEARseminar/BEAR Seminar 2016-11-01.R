################################################################################
############################### INSTALLING CRASCH ##############################

# This first package allows you to install from github
install.packages("devtools")

# Install crasch
devtools::install_github("amyarneson/crasch")
# This may take a few minutes; multiple packages will be installed
# You may see some warning messages, and that's okay!

# Use the same command to update the package as changes are made.


################################################################################
############################### GETTING STARTED ################################

library(crasch)

# You can view the input objects
View(ADPcons) # Construct information input
View(ADPitem) # Item information input
View(ADPwide) # Scores in wide format


################################################################################
############################## STANDARD ANALYSIS ###############################

?craschR  # check out the argument options and description

ADP = craschR(scores = ADPwide, itemInfo = ADPitem, consInfo = ADPcons,
              varsInfo = ADPvars, writeout = FALSE)

# Use MLEs or WLEs for person estimates
ADP_MLE = craschR(scores = ADPwide, itemInfo = ADPitem, consInfo = ADPcons,
                  varsInfo = ADPvars, persMethod = "MLE", writeout = FALSE)
ADP_WLE = craschR(scores = ADPwide, itemInfo = ADPitem, consInfo = ADPcons,
                  varsInfo = ADPvars, persMethod = "WLE", writeout = FALSE)

# View the different estimates in a table
cbind(ADP$persPars, ADP_MLE$persPars, ADP_WLE$persPars)

# See the output provided by craschR()
names(ADP)

# See the help documentation for information on the format of each element of 
#  the list.
View(ADP$itemPars)
View(ADP$persPars)
ADP$estSummary


################################################################################
########################## POST-ESTIMATION FUNCTIONS ###########################

### item.scores () ###

  ?item.scores
  item.scores(ADP)
  # To graph proportions instead of frequencies, use freqs = FALSE
    item.scores(ADP, freqs = FALSE)

  # Color Brewer is a great tool!  colorbrewer2.org
    display.brewer.all() # creates a graphic with the palettes displayed + names
    # You can use any color brewer palette in crasch
      item.scores(ADP, palette = "Set2")
      item.scores(ADP, palette = "Reds")

      
### GRAPHIC FILE WRITEOUT OPTIONS ###
  
  # PDF is the default file type, but can be difficult to work with in MS Office
    item.scores(ADP, writeout = TRUE)
    item.scores(ADP_MLE, writeout = TRUE, fileSuffix = "MLE")
  # PDF is a vectorized graphic type which makes it ideal if you are going to
  #   include on a poster or other professional presentation medium.  SVG 
  #   graphics are also vectorized (extra software may be required).
  
  # PNG is a lower-quality graphic, but is easily inserted in MS doc & ppt files
    item.scores(ADP, writeout = TRUE, imageType = "png")
  
  # JPEG, Bitmap, and TIFF graphics are also supported
    item.scores(ADP, writeout = TRUE, imageType = "jpeg")
    item.scores(ADP, writeout = TRUE, imageType = "bmp")
    item.scores(ADP, writeout = TRUE, imageType = "tiff")
  
    
### pers.hist() ###
  ?pers.hist
  pers.hist(ADP)
  
  pers.hist(ADP, palette = "Spectral")
  # You can also specify any 2 R colors in a vector
    pers.hist(ADP, palette = c("red", "darkred"))

    
### KIDMAP() ###

  ?KIDMAP
  # For the KIDMAP function you must specify a respondent ID!
  # To look at the list of your IDs:
    row.names(ADPwide)
    
  KIDMAP(ADP, 120)
  
  # You can change the colors and write options as above
    KIDMAP(ADP, 120, palette = "Spectral")
  # You can also specify any 3 R colors in a vector
    KIDMAP(ADP, 147, palette = c("darkred", "red", "black"))


### item.analysis() ###
  
  ?item.analysis
  item.analysis(ADP)
  # Only the item table:
    item.analysis(ADP)[[1]]
  # Only the step table:
    item.analysis(ADP)[[2]]
    
    
### infit.MNSQ() ###
  ?infit.MNSQ
    
  infit.MNSQ(ADP)
    
  # To plot the step fit instead of the overall item fit:
    infit.MNSQ(ADP, params = "steps")
    
  # To restrict which items are plotted on each graph:
    infit.MNSQ(ADP, itemOrder = c(1, 2, 3, 4, 5, 6, 7), params = "steps")
    infit.MNSQ(ADP, itemOrder = 8:13, params = "steps")
    
    
### CPC.graph() ###
  ?CPC.graph
  CPC.graph(ADP) # Note that a separate graph is produced for each item
  
  # To selectively produce graphs use itemOrder
    CPC.graph(ADP, itemOrder = c(1, 13))
  
  # To plot your observed proportions, use observed and minCell
    CPC.graph(ADP, itemOrder = 13, observed = TRUE)
    CPC.graph(ADP, itemOrder = 13, observed = TRUE, minCell = 3)
    
  # You can also plot "vertically" as in Wilson (2005)
    CPC.graph(ADP, itemOrder = 13, logitAxis = "y")
    
    
### ICC.graph() ###
  ?ICC.graph
  ICC.graph(ADP) # produces a graph for each item
  
  # itemOrder works as in the CPC.graph() function
    ICC.graph(ADP, itemOrder = c(5:6))
  
    
### info.graph() ###
  ?info.graph
    
  # for standard error of measurement (the default):
    info.graph(ADP, type = "SEM")  # SEM is the default
  # for test information curve:
    info.graph(ADP, type = "TIC")  # produces one graph
  # for item information curveS
    info.graph(ADP, type = "IIC")  # produces one graph for each item

    
### wm() ###
  
  ?wm
    
  wm(ADP) # organized in item order
  wm(ADP, byCat = TRUE) # organized in construct category order
  
  # If you want to customize the output further, see the `wrightMap()` function 
  #  documentation.  The function provided in this package is merely a wrapper.
    ?wrightMap

  
### Split.halves() ###
  
  ?Split.halves # be sure to use a capital S
  
  # You will need to run craschR() twice before running Split.halves().
  # You can either make new item and score files for each run, or manipulate 
  #    existing objects in R.
  
  # If you want to do this in R, you can use the following code as a template.
  #    Note that you only have to change the item and score objects.  The
  #    construct information is the same for both.  The variable object is not
  #    relevant, so you don't have to worry about that at all.
  item1 = ADPitem[c(2, 5, 7, 8, 10, 11), ]      # selects rows
  scores1 = ADPwide[ , c(2, 5, 7, 8, 10, 11)] # selects columns
  
  item2 = ADPitem[c(1, 3, 4, 6, 9, 12, 13), ]
  scores2 = ADPwide[ , c(1, 3, 4, 6, 9, 12, 13)]
  
  ### Make sure each item is included in only 1 of the halves! ###
  
  # Use the same persMethod that you did for the original analysis
  results1 = craschR(scores1, item1, ADPcons, writeout = FALSE)
  results2 = craschR(scores2, item2, ADPcons, writeout = FALSE)
  
  Split.halves(results1, results2)
  

### mn.traj() ###
  ?mn.traj
  mn.traj(ADP)
  
  
### Sp.rho() ###
  ?Sp.rho
  
  # For this, we will use some sample data that is fully dichotomous included in
  #   the package.  There are 14 items.
    DIresults = craschR(scores = DIwide, itemInfo = DIitem, consInfo = DIcons)
  
  Sp.rho(DIresults, expOrder = c(14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1))
  