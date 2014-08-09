

make_beast_xml <- function(seq_data, f_name, min_root, max_root){

	       block1 <- "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><beast beautitemplate=\'Standard\' beautistatus=\'\' namespace=\"beast.core:beast.evolution.alignment:beast.evolution.tree.coalescent:beast.core.util:beast.evolution.nuc:beast.evolution.operators:beast.evolution.sitemodel:beast.evolution.substitutionmodel:beast.evolution.likelihood\" version=\"2.0\">\n"

	       block2 <-"<data \nid=\"FILENAME\" \nname=\"alignment\">"

	       seq_template <-  "<sequence id=\"seq_TAXON\" taxon=\"TAXON\" totalcount=\"4\" value=\"SEQUENCEDATA\"/>"

#loop to get blocks for sequences

      seq_block <- vector()
      for(i in 1:nrow(seq_data)){
      	    seq_block[i] <- gsub('TAXON', rownames(seq_data)[i], seq_template)
      	    seq_block[i] <- gsub('SEQUENCEDATA', paste0(as.character(seq_data[i, ]), collapse = ''), seq_block[i])      
       }

       seq_block <- paste(seq_block, sep = '\n',  collapse = '\n')

       block3 <- "</data>"

       block4 <- "<map name=\"Beta\">beast.math.distributions.Beta</map>\n<map name=\"Exponential\">beast.math.distributions.Exponential</map>\n<map name=\"InverseGamma\">beast.math.distributions.InverseGamma</map>\n<map name=\"LogNormal\">beast.math.distributions.LogNormalDistributionModel</map>\n<map name=\"Gamma\">beast.math.distributions.Gamma</map>\n<map name=\"Uniform\">beast.math.distributions.Uniform</map>\n<map name=\"prior\">beast.math.distributions.Prior</map>\n<map name=\"LaplaceDistribution\">beast.math.distributions.LaplaceDistribution</map>\n<map name=\"OneOnX\">beast.math.distributions.OneOnX</map>\n<map name=\"Normal\">beast.math.distributions.Normal</map>"

       block5 <- "<run chainLength=\"1000000\" id=\"mcmc\" spec=\"MCMC\">\n    <state id=\"state\" storeEvery=\"5000\">\n        <tree id=\"Tree.t:FILENAME\" name=\"stateNode\">\n            <taxonset id=\"TaxonSet.FILENAME\" spec=\"TaxonSet\">\n                <data\nidref=\"FILENAME\"\nname=\"alignment\"/>\n            </taxonset>\n        </tree>"

       block6 <- "        <parameter id=\"birthRate.t:FILENAME\" name=\"stateNode\">1.0</parameter>
        <parameter id=\"mutationRate.s:FILENAME\" name=\"stateNode\">1.0</parameter>
        <parameter id=\"ucldStdev.c:FILENAME\" lower=\"0.0\" name=\"stateNode\" upper=\"5.0\">0.5</parameter>
        <stateNode dimension=\"98\" id=\"rateCategories.c:FILENAME\" spec=\"parameter.IntegerParameter\">1</stateNode>
        <parameter id=\"ucldMean.c:FILENAME\" name=\"stateNode\">1.0</parameter>
    	</state>
    	"

	block7 <- "    <init estimate=\"false\" id=\"RandomTree.t:FILENAME\" initial=\"@Tree.t:FILENAME\" spec=\"beast.evolution.tree.RandomTree\" taxa=\"@FILENAME\">
        <populationModel id=\"ConstantPopulation0.t:FILENAME\" spec=\"ConstantPopulation\">
            <parameter id=\"randomPopSize.t:FILENAME\" name=\"popSize\">1.0</parameter>
        </populationModel>
    	</init>
	"

	block8 <- "    <distribution id=\"posterior\" spec=\"util.CompoundDistribution\">
               <distribution id=\"prior\" spec=\"util.CompoundDistribution\">
            <distribution birthDiffRate=\"@birthRate.t:FILENAME\" id=\"YuleModel.t:FILENAME\" spec=\"beast.evolution.speciation.YuleModel\" tree=\"@Tree.t:FILENAME\"/>
            <prior id=\"YuleBirthRatePrior.t:FILENAME\" name=\"distribution\" x=\"@birthRate.t:FILENAME\">
                <Uniform id=\"Uniform.0\" name=\"distr\" upper=\"Infinity\"/>
            </prior>
            <prior id=\"MutationRatePrior.s:FILENAME\" name=\"distribution\" x=\"@mutationRate.s:FILENAME\">
                <OneOnX id=\"OneOnX.0\" name=\"distr\"/>
            </prior>
            <prior id=\"MeanRatePrior.c:FILENAME\" name=\"distribution\" x=\"@ucldMean.c:FILENAME\">
                <Uniform id=\"Uniform.01\" name=\"distr\" upper=\"Infinity\"/>
            </prior>
            <prior id=\"ucldStdevPrior.c:FILENAME\" name=\"distribution\" x=\"@ucldStdev.c:FILENAME\">
                <Exponential id=\"Exponential.0\" name=\"distr\">
                    <parameter estimate=\"false\" id=\"RealParameter.0\" name=\"mean\">0.3333</parameter>
                </Exponential>
            </prior>
            <distribution id=\"root_age.prior\" spec=\"beast.math.distributions.MRCAPrior\" tree=\"@Tree.t:FILENAME\">
	    "

	    block9 <-  "<taxonset id=\"root_age\" spec=\"TaxonSet\">"

	    # Run block to generate taxa block

	    taxa_pr_template <- "<taxon id=\"TAXON\" spec=\"Taxon\"/>"

	    taxa_block <- vector()
	    for(i in 1:nrow(seq_data)){
	      taxa_block[i] <- gsub("TAXON", rownames(seq_data)[i], taxa_pr_template)
	    }

	    taxa_block <- paste(taxa_block, sep = '\n', collapse = '\n')

	    block10 <- "</taxonset>"

	    #Block 11 is the calibration for the root node
	    block11 <- "<Uniform id=\"Uniform.02\" lower=\"LOW\" name=\"distr\" upper=\"HIGH\"/>
            	    </distribution>
        	    </distribution>
	     "

	      block11 <- gsub('LOW', min_root, block11)
	      block11 <- gsub('HIGH', max_root, block11)

	      block12 <- "<distribution id=\"likelihood\" spec=\"util.CompoundDistribution\">
               <distribution data=\"@FILENAME\" id=\"treeLikelihood.FILENAME\" spec=\"TreeLikelihood\" tree=\"@Tree.t:FILENAME\">
                 <siteModel id=\"SiteModel.s:FILENAME\" mutationRate=\"@mutationRate.s:FILENAME\" spec=\"SiteModel\">
                   <parameter estimate=\"false\" id=\"gammaShape.s:FILENAME\" name=\"shape\">1.0</parameter>
                   <parameter estimate=\"false\" id=\"proportionInvariant.s:FILENAME\" lower=\"0.0\" name=\"proportionInvariant\" upper=\"1.0\">0.0</parameter>
                    <substModel id=\"JC69.s:FILENAME\" spec=\"JukesCantor\"/>
                </siteModel>
                <branchRateModel clock.rate=\"@ucldMean.c:FILENAME\" id=\"RelaxedClock.c:FILENAME\" rateCategories=\"@rateCategories.c:FILENAME\" spec=\"beast.evolution.branchratemodel.UCRelaxedClockModel\" tree=\"@Tree.t:FILENAME\">
                    <LogNormal S=\"@ucldStdev.c:FILENAME\" id=\"LogNormalDistributionModel.c:FILENAME\" meanInRealSpace=\"true\" name=\"distr\">
                               <parameter estimate=\"false\" id=\"RealParameter.01\" lower=\"0.0\" name=\"M\" upper=\"1.0\">1.0</parameter>
                    	</LogNormal>
                    </branchRateModel>
            	</distribution>
            </distribution>
    	</distribution>
    "

	block13 <- "<operator id=\"YuleBirthRateScaler.t:FILENAME\" parameter=\"@birthRate.t:FILENAME\" scaleFactor=\"0.75\" spec=\"ScaleOperator\" weight=\"3.0\"/>
          <operator id=\"treeScaler.t:FILENAME\" scaleFactor=\"0.5\" spec=\"ScaleOperator\" tree=\"@Tree.t:FILENAME\" weight=\"3.0\"/>
          <operator id=\"treeRootScaler.t:FILENAME\" rootOnly=\"true\" scaleFactor=\"0.5\" spec=\"ScaleOperator\" tree=\"@Tree.t:FILENAME\" weight=\"3.0\"/>
          <operator id=\"UniformOperator.t:FILENAME\" spec=\"Uniform\" tree=\"@Tree.t:FILENAME\" weight=\"30.0\"/>
          <operator id=\"SubtreeSlide.t:FILENAME\" spec=\"SubtreeSlide\" tree=\"@Tree.t:FILENAME\" weight=\"15.0\"/>
          <operator id=\"narrow.t:FILENAME\" spec=\"Exchange\" tree=\"@Tree.t:FILENAME\" weight=\"15.0\"/>
          <operator id=\"wide.t:FILENAME\" isNarrow=\"false\" spec=\"Exchange\" tree=\"@Tree.t:FILENAME\" weight=\"3.0\"/>
          <operator id=\"WilsonBalding.t:FILENAME\" spec=\"WilsonBalding\" tree=\"@Tree.t:FILENAME\" weight=\"3.0\"/>
          <operator id=\"mutationRateScaler.s:FILENAME\" parameter=\"@mutationRate.s:FILENAME\" scaleFactor=\"0.5\" spec=\"ScaleOperator\" weight=\"0.1\"/>
          <operator id=\"ucldStdevScaler.c:FILENAME\" parameter=\"@ucldStdev.c:FILENAME\" scaleFactor=\"0.5\" spec=\"ScaleOperator\" weight=\"3.0\"/>
          <operator id=\"CategoriesRandomWalk.c:FILENAME\" parameter=\"@rateCategories.c:FILENAME\" spec=\"IntRandomWalkOperator\" weight=\"10.0\" windowSize=\"1\"/>
          <operator id=\"CategoriesSwapOperator.c:FILENAME\" intparameter=\"@rateCategories.c:FILENAME\" spec=\"SwapOperator\" weight=\"10.0\"/>
          <operator id=\"CategoriesUniform.c:FILENAME\" parameter=\"@rateCategories.c:FILENAME\" spec=\"UniformOperator\" weight=\"10.0\"/>
          <operator id=\"ucldMeanScaler.c:FILENAME\" parameter=\"@ucldMean.c:FILENAME\" scaleFactor=\"0.5\" spec=\"ScaleOperator\" weight=\"1.0\"/>
          <operator id=\"relaxedUpDownOperator.c:FILENAME\" scaleFactor=\"0.75\" spec=\"UpDownOperator\" weight=\"3.0\">
         <parameter idref=\"ucldMean.c:FILENAME\" name=\"up\"/>
         <tree idref=\"Tree.t:FILENAME\" name=\"down\"/>
         </operator>
        "

	block14 <- "    <logger fileName=\"FILENAME.log\" id=\"tracelog\" logEvery=\"1000\" model=\"@posterior\" sanitiseHeaders=\"true\" sort=\"smart\">
          <log idref=\"posterior\"/>
          <log idref=\"likelihood\"/>
          <log idref=\"prior\"/>
          <log idref=\"treeLikelihood.FILENAME\"/>
          <log id=\"TreeHeight.t:FILENAME\" spec=\"beast.evolution.tree.TreeHeightLogger\" tree=\"@Tree.t:FILENAME\"/>
          <log idref=\"YuleModel.t:FILENAME\"/>
          <parameter idref=\"birthRate.t:FILENAME\" name=\"log\"/>
          <parameter idref=\"mutationRate.s:FILENAME\" name=\"log\"/>
          <parameter idref=\"ucldStdev.c:FILENAME\" name=\"log\"/>
          <log branchratemodel=\"@RelaxedClock.c:FILENAME\" id=\"rate.c:FILENAME\" spec=\"beast.evolution.branchratemodel.RateStatistic\" tree=\"@Tree.t:FILENAME\"/>
          <log idref=\"root_age.prior\"/>
          <parameter idref=\"ucldMean.c:FILENAME\" name=\"log\"/>
      </logger>

      <logger id=\"screenlog\" logEvery=\"1000\">
          <log idref=\"posterior\"/>
          <log arg=\"@posterior\" id=\"ESS.0\" spec=\"util.ESS\"/>
          <log idref=\"likelihood\"/>
          <log idref=\"prior\"/>
      </logger>

      <logger fileName=\"$(tree).trees\" id=\"treelog.t:FILENAME\" logEvery=\"1000\" mode=\"tree\">
        <log branchratemodel=\"@RelaxedClock.c:FILENAME\" id=\"TreeWithMetaDataLogger.t:FILENAME\" spec=\"beast.evolution.tree.TreeWithMetaDataLogger\" tree=\"@Tree.t:FILENAME\"/>
      </logger>

  </run>

  </beast>
  "

  xml_out <- paste(block1, block2, seq_block, block3, block4, block5, block6, block7, block8, block9, taxa_block, block10, block11, block12, block13, block14, sep = '\n', collapse= '\n')

  xml_out <- gsub('FILENAME', f_name, xml_out)

  return(xml_out)
}