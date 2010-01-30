#!/usr/bin/Rscript

##=============================================================================
##=============================================================================
## Analysis of Budget Forecasts of the Mt. Lebanon, Pennsylvania,
## School District.
##
## Primary sources:  April 2009 5-Year Budget Forecast
##                   January 28, 2010 5-Year Budget Forecast
##
## Analyis by Tom Moertel <tom@mlao.org>.
## 2010-01-29
##
## This analysis is an R program:  http://www.r-project.org/
##=============================================================================
##=============================================================================


options(digits = 2)
require("ggplot2")

## Load data
forecasts <- read.csv("forecasts.csv", header=T)

## Convert data into form useful for plotting
forecasts.melted <- melt(forecasts, "School.Year")
forecasts.useful <- transform(forecasts.melted,
                              forecast = substr(variable, 1, 3),
                              inc.exp = substr(variable, 5, 11))

## Generate summary plot
plot1 <-
qplot(School.Year, value / 1e6, data = forecasts.useful,
      main = "Comparison of Budget Forecasts\nMt. Lebanon School District",
      xlab = "School Year (Starting Year)",
      ylab = "Budget in $Millions",
      colour = forecast,
      linetype = inc.exp,
      geom = c("point", "line")) +
  scale_y_continuous(formatter="dollar") +
  scale_colour_hue("Forecast",
                   breaks=c("Old", "New"),
                   labels=c("April 2009", "Jan 2010")) +
  scale_linetype("Revenue/Expense",
                 breaks=c("Revenue", "Expense"),
                 labels=c("Revenue", "Expense"))
print(plot1)


## Save plot in PNG and PDF formats
ggsave("comparison-of-budget-forecasts-mtlsd.png",
      plot1, width = 8, height = 6, dpi = 100)
ggsave(file="comparison-of-budget-forecasts-mtlsd.pdf",
       plot = plot1,
       width=8.5, height=8.5)
