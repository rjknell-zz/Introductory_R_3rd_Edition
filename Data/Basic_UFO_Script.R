# Load data from website
UFO <- read.csv("http://www.introductoryr.co.uk/UFO_data.csv",
                stringsAsFactors = FALSE)

# Convert 'Reports' variable to date
UFO$Reports <- as.Date(UFO$Reports, format = "%d/%m/%Y")

# Trim off dates before 1900
UFO <- UFO[1:907,]

# Plot the data
plot(UFO$Count ~ UFO$Reports,
     type = 'l',
     col = "steelblue",
     xlab = "Year",
     ylab = "Number of UFO reports by month",
     main  = "UFO reports by month since 1900")

