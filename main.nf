left = Channel.watchPath("./aaa/*")


l1 = left.map{
        id = it.getName()
  
  [id, id]

}

right= Channel.from(['Z', 6], ['Y', 5], ['X', 4])
l1.join(right, remainder:true).println()
