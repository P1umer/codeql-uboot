/**
* @kind path-problem
*/

import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph
 
class NetworkByteSwap extends Expr {
    NetworkByteSwap () {
      exists(MacroInvocation mi |
        mi.getMacro().getName() in ["ntohs","ntohl","ntohll"] and
        this = mi.getExpr()
      )
    } 
  }

class Target extends Expr {
    Target () {
      exists( FunctionCall fc|
        fc.getTarget().getName() ="memcpy" and
        this = fc.getArgument(2)
      )
    } 
  }
 
class Config extends TaintTracking::Configuration {
  Config() { this = "NetworkToMemFuncLength" }

  override predicate isSource(DataFlow::Node source) {
    // TODO
    source.asExpr() instanceof NetworkByteSwap
  }
  override predicate isSink(DataFlow::Node sink) {
    // TODO
    sink.asExpr() instanceof Target

  }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"