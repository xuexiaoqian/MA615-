library(tidyverse)
library(car)

lu.dat <- read.csv(tidyverse_packages(lu.dat))
lu.dat <- mutate(lu.dat,lppg=log(ppgdp))
lu.dat

lu.dat $ group <- as.factor(lu.dat$group)

mod1 <- lm(fertility ~ lppg + pctUrban + group, data = lu.dat)
res.mod1 <- residuals (mod1) # full regression

mod.f <- lm(fertility <- pctUrban + group, data = lu.dat)
res.f <-residuals(mod.f)

unique(lu.dat $ region)

mod.ppg <-lm (lppg <- pctUrban + group, data = lu.dat)
res.ppg <- residuals(mmd.ppg)

partial.f <- lm (res.f ~res.ppg)

head (mod1$residuals)
head (partial.f$residuals)

avPlots (partial)

