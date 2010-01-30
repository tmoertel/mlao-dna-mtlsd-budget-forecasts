# This a Makefile.  Run "make" from the command line to have the
# GNU Make program read this file and use the rules within it to
# perform the statistical analyses and generate the resulting
# charts and other outputs.
#
# Tom Moertel <tom@mlao.org>
# 2009-10-11


all_charts = $(charts)

analysis = budget.R
charts = comparison-of-budget-forecasts-mtlsd.pdf \
         comparison-of-budget-forecasts-mtlsd.png


default: all

.PHONY: default

.PHONY: all
all: $(all_charts)

$(charts): $(analysis)
	./$(analysis)


.PHONY: clean
clean:
	rm -f $(all_charts)
