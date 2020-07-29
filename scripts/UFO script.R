# Script to read data on UFO reports and plot the data since 1900
# Audrey Bloggs 25th December 2022

library(lubridate)
library(XML)
library(stringr)

# Read table of reports by month from the web page of National UFO Reporting 
# Center. 
# This returns a list with a NULL object hence the subscripting at the end

UFO <- readHTMLTable("http://www.nuforc.org/webreports/ndxevent.html",
                     stringsasfactors = FALSE, # don't know why this doesn't work
                     header = TRUE,
                     colClasses = c("character", "integer"))[[1]]

# Can't work out how to avoid importing the dates as a factor so convert to a 
# character here
UFO$Reports <- as.character(UFO$Reports)

# Make the dates readable by lubridate (1) replace "/" with "-"
UFO_reports <- str_replace(UFO$Reports, "/", "-")

# (2) Add fake day numbers to the start of the dates because they are in 
# month-year only
UFO_reports <- paste("01-", UFO_reports, sep = "")

# Convert chr to dates
UFO$Reports <- dmy(UFO_reports)

# Trim off the dates before 1900
UFO <- UFO[which(as.numeric(year(UFO$Reports)) > 1899), ]

# Clean up
rm(temp_data, UFO_reports)

# Plot the data
plot(UFO$Count ~ UFO$Reports,
     type = 'l',
     col = "steelblue",
     xlab = "Year",
     ylab = "Number of UFO reports by month",
     main  = "UFO reports by month since 1900")

#Extract the data for the 80s
eighties_UFOs <- UFO[which(year(UFO$Reports) %in% 1980:1989), ]

#Plot 80s data

#Adjust the margins to include the title text
par(mar = c(4,4,4,2))

plot(eighties_UFOs$Count ~ eighties_UFOs$Reports,
     ylim = c(0, 90),
     type = 'l',
     col = "steelblue",
     xlab = "Year",
     ylab = "Number of UFO reports by month")

mtext("UFO reports by month for the 1980s",
      side = 3,
      line = 2,
      font = 2)

mtext("Vertical lines indicate June of each year",
      side = 3,
      line = 1,
      font = 2,
      cex = 0.8,)


#Add lines for June of each year
segments(x0 = eighties_UFOs$Reports[which(as.numeric(month(eighties_UFOs$Reports)) == 6)],
         y0 = rep(-5, times = 10),
         x1 = eighties_UFOs$Reports[which(as.numeric(month(eighties_UFOs$Reports)) == 6)],
         y1 = eighties_UFOs$Count[which(as.numeric(month(eighties_UFOs$Reports)) == 6)],
         lty = 2,
         lwd = 0.8)

