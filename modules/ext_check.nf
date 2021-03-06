process fasta_check { 
        label 'ubuntu'
      input:
       set val(sample), val(bin_id), file(file)
      output:
       set val(name), val(bin_id), file("${bin_id}.fa")
      shell:
        """
       case "${file}" in
            *.gz)
                zcat !{file} > ${bin_id}.fa
                ;;
            *.fasta)
                
                cp !{file} ${bin_id}.fa
                ;;
            *.fa)
                cp !{file} ${bin_id}.fa
                ;;
            *)
                echo "file format not supported...what the phage...(.fa .fasta .fna .gz is supported)"
                exit 1
        esac
        """
    }