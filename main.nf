ch = Channel.from("a1", "a3", "a5")

def Correspondence = [:]
Correspondence["MS2specCount"] = ["a1" : "0000001" , "a3": "0000003", "a5": "0000005"  ]
println(Correspondence["MS2specCount"]["a1"])

println(Correspondence)

process storenum {
    publishDir "storenum"
	tag { number }
	
    input:
    val number from ch

    output:
    set number, file("${Correspondence['MS2specCount'][number]}.file") into number_files
    
    script:
    def id = Correspondence['MS2specCount'][number]
    """
		echo ${id} > ${id}.file
    """
}

process otherstuff {
    publishDir("ciccio")
    input:
    set number, number_file from number_files

    output:
	file("${number}.newfile")
	  
    script:
    """
		cat ${number_file} > ${number}.newfile
    """
}