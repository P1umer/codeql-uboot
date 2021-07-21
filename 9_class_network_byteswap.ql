import cpp
// from Macro m,MacroInvocation mi 
// where 
//     m.getName() in ["ntohs","ntohl","ntohll"] and
//     mi =m.getAnInvocation()
// select mi.getExpr(),"Hello MacroInvocation2"
class NetworkByteSwap extends Expr {
    NetworkByteSwap () {
      exists(MacroInvocation mi |
        mi.getMacro().getName() in ["ntohs","ntohl","ntohll"] and
        this = mi.getExpr()
      )
    } 
  }

from NetworkByteSwap n
select n, "Network byte swap" 
