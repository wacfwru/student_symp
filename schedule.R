
## script run on 04 Oct 2019

## set seed for random drawing of speaker order
seed <- unclass(Sys.Date()) ## = 18172
set.seed(seed)

## read student info
students <- read.csv("./data/student_info.csv")

## begin by ordering students by first name
students <- students[order(students[,1]),]

## number of speakers
n_students <- length(students$Name)

## then randomize order
students <- students[sample(seq(n_students)),]

## welcoming people
welcome <- data.frame(Name = "Sarah Converse & Mark Scheuerell",
                      Affiliation = "Washington Cooperative Fish and Wildlife Research Unit",
                      Title = "Welcome")

## awards people
awards <- data.frame(Name = "Sarah Converse & Mark Scheuerell",
                     Affiliation = "Washington Cooperative Fish and Wildlife Research Unit",
                     Title = "Awards presentation")

## all speakers
speaker_lineup <- rbind(welcome, students, awards)

## set up time slots
## start time for seminar = 4:00 PM PDT = 
seminar_start <- ISOdate(2019,10,23) + 60*60*11
## introduction time = 10 min; specified in seconds
intro_start <- 10*60 
## student start times
student_start <- seq(seminar_start + intro_start,
                   by = "9 min",
                   length.out = n_students)
## awards start 9 min after last students starts; specified in seconds
awards_time <- student_start[n_students] + 9*60

all_times <- c(seminar_start, student_start, awards_time)

format(all_times, "%I:%M %p")

schedule <- cbind(Time = format(all_times, "%I:%M %p"),
                  speaker_lineup)

write.csv(schedule, "WACFWRU_symposium_schedule.csv", row.names = FALSE)

