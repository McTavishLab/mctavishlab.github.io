TO USE THE GARLI GAP MODELS

1. PUT YOUR ALIGNMENT IN THIS DIRECTORY
    (for tutorial, tutorialData.fas)

2. TO PREPARE THE GAP CODED DATA FOR GARLI, EXECUTE EITHER 
    ./prepareFastaData.sh myAlignment.fas
or
    ./prepareNexusData.sh myAlignment.nex

3. TO ANALYZE THE CREATED DATASETS, EXECUTE EITHER
    ./runGarli.dna+gapModels.sh
    TO RUN DNA alone, DNA+DIMM and DNA+Mkv MODELS
OR
    ./runGarli.indelMixtureOnly.sh
    TO ONLY RUN DIMM MODEL

-Note that the DIMM output tree will contain a taxon 
    called ROOT, which is essentially an outgroup that
    indicates the inferred root.  This can be deleted.
    Note that to load this tree into a program like
    PAUP, the alignment must also contain a dummy taxon
    name ROOT.  A script will try to make this for you
    if possible, or your might need to manually do so.


LET ME KNOW OF ANY ISSUES
Derrick Zwickl
garli.support@gmail.com

