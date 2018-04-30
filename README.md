# Time Series

The purpose of this project is to design a standardised protocol for the analysis of palaeontological time series data. This will include aspects such as:

- How to treat missing data.
- The optimal method of 'detrending'.
- Autoregressive models.
- How to treat residual data, and statistical biases.
- Model-fitting and correlation analyses.

########################################

## How to execute SQS in both R and Perl.

First step is to download a list of fossil occurrences from the [Paleobiology Database](https://paleobiodb.org/cgi-bin/bridge.pl?a=displayDownloadGenerator).

Handily, this generates a .csv file, which makes it dead easy to use in R and Perl. Make sure to download all the files you can at this stage. You never know! 

NOTE: The data reference provided here contains the names of those who have authorised and contributed data to each dataset. However, it excludes contributors who are not authorisers themselves (e.g., grad students), which you need to check separately in each file. There is an option to include this information in each download request.

PROTIP: Always check this csv file for data misalignments. Depending on the program you use to visualise the data, it could get messy, and the encodings might be weird for some characters. Ideally, you want a nice, clean csv file with UTF-8 character coding, with the columns appropriately delimited by commas. If this is not the case, you might have to do some fiddling with the data, cleaning up misalignments. This can occur, for example, when data within cells contains commas itself, which can mis-align all subsequent cells.

### PERL
Make sure [Perl](https://www.perl.org/) is installed. Have the [Time Bins file](https://github.com/Meta-Paleo/TimeSeries/blob/master/time_bins.txt), [Perl script](https://github.com/Meta-Paleo/TimeSeries/blob/master/SQS.pl), and occurrences file in the same working directory. 

Make sure the Perl script is pointing to each of these files. There are many options you can play with here, and it's worth consulting John Alroy's papers (and those which describe the application of his method in detail) so you know what these do in advance. You can edit the script in a standard text editor such as Notepad.

Simply double click the script then to run it. It should cycle through and spit out several results files. Then simply go through the results and voila! The one of most interest will be subsampled diversity, and also Good's u.

### R
I think you have to do this one time bin by time bin, which can get a bit tedious. Simply read in a list of taxonomic names, and convert this to an occurrence list using the table() function. The script is available [here](https://github.com/Meta-Paleo/TimeSeries/blob/master/SQS_bootstrap.r).

The bootstrap code for this version will generate the median and 95% confidence intervals for each time bin. Most previous research on diversity misses this out (including some of mine!), which makes interpretation difficult.

## Key papers
[Alroy, 2010](https://www.cambridge.org.sci-hub.tw/core/journals/the-paleontological-society-papers/article/fair-sampling-of-taxonomic-richness-and-unbiased-estimation-of-origination-and-extinction-rates/F4E5329EB9A76CC317A591E2A3FA41D4): Fair Sampling of Taxonomic Richness and Unbiased Estimation of Origination and Extinction Rates.

[Alroy, 2010](https://onlinelibrary.wiley.com/doi/full/10.1111/j.1475-4983.2010.01011.x): Geographical, environmental and intrinsic biotic controls on Phanerozoic marine diversification.

[Tennant et al., 2017](https://www.nature.com/articles/ncomms12737/): Sea level regulated tetrapod diversity dynamics through the Jurassic/Cretaceous interval (see the SI especially).

[Close et al., 2017](https://www.nature.com/articles/ncomms15381): Controlling for the species-area effect supports constrained long-term Mesozoic terrestrial vertebrate diversification.

[Close et al., 2018](https://besjournals.onlinelibrary.wiley.com/doi/abs/10.1111/2041-210X.12987): How should we estimate diversity in the fossil record? Testing richness estimators using sampling‐standardised discovery curves.

[Tennant et al., 2018](https://peerj.com/articles/4417/): How has our knowledge of dinosaur diversity through geologic time changed through research history? (More via [paleorXiv](https://osf.io/nuhqx/)).
