library(dplyr)
library(readxl)
library (lubridate)
setwd("C:/Users/apeaning/Desktop/SWITCH_NY/Aggregate Data")
Gen <- read_excel("New_Generation.xlsx")
str(Gen)
Gen$build_year<-year(Gen$Date)
### Note Aggregating into 4 Zones i.e. NYC , West Hudson Valley(HV) & LI
### Aggregations done by fuel type, year of power plant (for tracking vintage)
Gen<-Gen %>% mutate(Zone_4=recode(Zone, 
                         "J"="NYC",
                         "K"="LI","A"="West","B"="West","C"="West","D"="West","E"="West",
                         "F"="HV","G"="HV","H"="HV","I"="HV"))

Gen_new<-Gen %>%       
  group_by(Zone_4,build_year,Fuel_1,unit_type) %>% 
  summarise_at(vars(Cap_MW),
               list(name = sum))

Gen_new$GENERATION_PROJECT <- paste(paste(Gen_new$Zone_4,Gen_new$Fuel_1, sep = "-"),Gen_new$unit_type, sep = "_")

write.csv(Gen_new,"Zone_Gen.csv")
