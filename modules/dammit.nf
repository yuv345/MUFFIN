process dammit { 
        label 'dammit' 
      input:
        val(name), file(transcript)
        file(db)
      output:
        val(name), file("*.dammit.fasta"), file("*.dammit.gff3")
      script:
        if (params.dammmit_user_db) {"""
        dammit annotate ${transcript} --user-databases ${params.dammmit_user_db} --busco-group ${params.busco_db} --n_threads ${task.cpus} -o ${name}_out --database-dir ${db} 
        cp ${name}_out/${transcript}.dammit.fasta ${name}.dammit.fasta
        cp ${name}_out/${transcript}.dammit.gff3 ${name}.dammit.gff3
        """}
        else {"""
        dammit annotate ${transcript}  --busco-group ${params.busco_db} --n_threads ${task.cpus} -o ${name}_out --database-dir ${db} 
        cp ${name}_out/${transcript}.dammit.fasta ${name}.dammit.fasta
        cp ${name}_out/${transcript}.dammit.gff3 ${name}.dammit.gff3
        """}
    }
            //--n newname for the transcrip?
            // --force?
            // --quick as a param?

            // SHOULD BE
        // dammit annotate ${transcript} --user-databases ${params.dammmit_user_db} --busco-group ${params.busco_db} --n_threads ${task.cpus} -o ${name}_out --database-dir ${db} 
        // cp ${name}_out/${transcript}.dammit.fasta ${name}.dammit.fasta
        // cp ${name}_out/${transcript}.dammit.gff3 ${name}.dammit.gff3