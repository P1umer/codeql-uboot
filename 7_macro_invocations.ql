import cpp
from Macro m,MacroInvocation mi 
where 
    m.getName() in ["ntohs","ntohl","ntohll"] and
    mi =m.getAnInvocation()
select mi,"Hello MacroInvocation"
