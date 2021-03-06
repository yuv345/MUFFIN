process contig_list {
    label 'ubuntu'
    input:
    set val(name), file(bins)
    output:
    set val(name), file("*.contigs.list")
    shell:\
    """
    for bin in !{bins}/bin.*.fa
        do
        bin_name=\$(basename \$bin )
        cat \$bin | grep -o -E "^>\\w+\\.\\w+" |sed 's/>//g'| tr -d "@" > \$bin_name.contigs.list ;
        done ;
    """
}

