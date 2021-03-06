process refine2 {
    // label 'metawrap'
    conda '/home/renaud/miniconda3/envs/metawrap-env'
    publishDir "${params.output}/${name}/metawrap_refined_bins/", mode: 'copy', pattern: "metawrap_bins" 
    publishDir "${params.output}/${name}/metawrap_refined_bins/", mode: 'copy', pattern: "${name}_binning_stats.txt" 
    input:
    set val(name1), file(bins1), file(bins2)
    file(path)
    output:
    set val(name1), file("metawrap_bins")
    file("${name}_binning_stats.txt")
    shell:
    """
    mem=\$(echo !{task.memory} | sed 's/ GB//g')
    path_db=\$(cat !{path})
    echo \$path_db
    echo -e "\$path_db" | checkm data setRoot
    echo "checkm done"
    metawrap bin_refinement -t !{task.cpus} -m \$mem -o refined_bins -A !{bins1} -B !{bins2} -o refined_bins
    mkdir metawrap_bins/
    mv refined_bins/metawrap_70_10_bins/*.fa metawrap_bins/
    mv refined_bins/metawrap_70_10_bins.stats ${name}_binning_stats.txt
    """

}

process refine3 {
    // label 'metawrap'
    conda '/home/renaud/miniconda3/envs/metawrap-env'
    publishDir "${params.output}/${name}/metawrap_refined_bins/", mode: 'copy', pattern: "metawrap_bins" 
    publishDir "${params.output}/${name}/metawrap_refined_bins/", mode: 'copy', pattern: "${name}_binning_stats.txt" 
    input:
        set val(name), file(bins1), file(bins2), file(bins3)
        file(path)
    output:
    set val(name), file("metawrap_bins/*.fa")
    file("${name}_binning_stats.txt")
    shell:
    """
    mem=\$(echo !{task.memory} | sed 's/ GB//g')
    path_db=\$(cat !{path})
    echo \$path_db
    echo -e "\$path_db" | checkm data setRoot
    echo "checkm done"
    metawrap bin_refinement -o refined_bins -A !{bins2} -B !{bins3} -C !{bins1} -t !{task.cpus} -m \$mem 
    mkdir metawrap_bins/
    mv refined_bins/metawrap_70_10_bins/*.fa metawrap_bins/
    mv refined_bins/metawrap_70_10_bins.stats !{name}_binning_stats.txt
    """

}

    // cp -r /home/renaud/mafin_modul/metawrap/metawrap_bins .
    // cp /home/renaud/mafin_modul/metawrap/S_41_17_Cf_binning_stats.txt .

     