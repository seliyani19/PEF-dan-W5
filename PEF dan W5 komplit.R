#membaca data dari URL
library(readr)
PEF <- read_csv("https://raw.githubusercontent.com/dwi-agustian/biostat/main/pef.csv")

library(readr)
w5 <- read_csv("https://raw.githubusercontent.com/dwi-agustian/biostat/main/w5.csv")

# Convert character to number: pidlink
w5<- w5%>%
  mutate(pidlink_num = as.numeric(pidlink))

w5<- w5 %>%
  mutate(pidlink_num = as.integer(pidlink))

#mengcopy paste variable pidlink asli
w5$pidlink_chr = w5$pidlink

#mereplace pidlink dengan versi int(num)
w5$pidlink = w5$pidlink_num

glimpse(w5)

w5_pef_fj = full_join(w5, PEF, by = "pidlink")

class(w5_pef_fj$sex)
w5$sex = as.factor(w5$sex)

class(w5_pef_fj$Asthma)
w5$Asthma = as.factor(w5$Asthma)

class(w5_pef_fj$agegr)
w5_pef_fj$agegr = as.factor(w5_pef_fj$agegr)

glimpse(w5_pef_fj)

table(w5_pef_fj$Asthma)
table(w5_pef_fj$age)
table(w5_pef_fj$agegr)
table(w5_pef_fj$sex)

#memilih berdasarkan kriteria tidak missing(NA)
w5_pef_c = filter(w5_pef_fj,!is.na(pef)&!is.na(height)&!is.na(age)&!is.na(sex)&!is.na(Asthma)&!is.na(agegr))

#subsetting data set
#subsetting variables
#memilih berdasarkan nama variables
w5_pef_komplit  = select(w5_pef_c, pidlink, age, agegr, sex, pef, height, Asthma)

glimpse(w5_pef_komplit)

table(w5_pef_komplit$Asthma)
table(w5_pef_komplit$age)
table(w5_pef_komplit$agegr)
table(w5_pef_komplit$sex)
table(w5_pef_komplit$pef)

summary(w5_pef_komplit)

w5_pef_komplit1  = filter(w5_pef_komplit, Asthma!="NAAsth")
w5_pef_komplit2 = filter(w5_pef_komplit1, Asthma!="Don't Know-Asth")

table(w5_pef_komplit2$Asthma)

write.csv(w5_pef_komplit2)
                         
                         