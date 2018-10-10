ch = Channel.from("1", "3", "5")

def Correspondence = [:]
Correspondence["MS2specCount"] = ["1" : "0000001" , "3": "0000003", "5": "0000005"  ]

process storenum {
    publishDir "storenum"
	tag { number }
	
    input:
    val number from ch

    output:
    set number, file("${Correspondence['MS2specCount'][ch]}.file") into number_files
    
    script:
    def id = Correspondence['MS2specCount'][ch]
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