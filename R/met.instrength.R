# Copyright (C) 2018  Sebastian Sosa, Ivan Puga-Gonzalez, Hu Feng He,Peng Zhang, Xiaohua Xie, Cédric Sueur
#
# This file is part of Animal Network Toolkit (ANT).
#
# ANT is a free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# ANT is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

#' @title Instrength
#' @description Calculates the node metric met.instrength for all vertices.
#' @param M a square adjacency matrix, or a list of square adjacency matrices, or an output of ANT functions \emph{stat.ds.grp}, \emph{stat.df.focal}, \emph{stat.net.lk}.
#' @param df a data frame of same length as the input matrix or a list of data frames if argument \emph{M} is a list of matrices or an output of ANT functions \emph{stat.ds.grp}, \emph{stat.df.focal}, \emph{stat.net.lk}.
#' @param dfid an integer or a string indicating the column with individual ids in argument \emph{df}.
#' @return 
#' \itemize{
#' \item An integer vector of nodes \emph{instrength} if argument \emph{df} is \emph{NULL}.
#' \item A list of integer vectors of nodes \emph{instrength} if argument \emph{M} is a list of matrices and if argument \emph{df} is \emph{NULL}.
#' \item A list of arguments df with a new column for nodes \emph{instrength} titled 'instrength', if argument \emph{df} is not \emph{NULL}.
#' \item A list of arguments df with a new column for nodes \emph{instrength} if 1) argument \emph{df} is not \emph{NULL}, 2) argument \emph{M} is an output from ANT functions \emph{stat.ds.grp}, \emph{stat.df.focal}, \emph{stat.net.lk} for multiple matrices permutations, and 3) argument \emph{df} is a list of data frames of same length as argument \emph{M}. The name of the column of each element of the list is adapted according to argument value \emph{binary}.
#' }
#' @details  Instrength of a node \emph{i} is the sum of the strengths of all edges directed towards node \emph{i}.
#' @author Sebastian Sosa, Ivan Puga-Gonzalez.
#' @references Freeman, L. C. (1978). Centrality in social networks conceptual clarification. Social networks, 1(3), 215-239.
#' @references Barrat, A., Barthelemy, M., Pastor-Satorras, R., & Vespignani, A. (2004). The architecture of complex weighted networks. Proceedings of the National Academy of Sciences of the United States of America, 101(11), 3747-3752.
#' @references Sosa, S. (2018). Social Network Analysis, \emph{in}: Encyclopedia of Animal Cognition and Behavior. Springer.
#' @examples
#' met.instrength(sim.m)
#'head(sim.df)
#' met.instrength(sim.m,df=sim.df)

met.instrength<-function(M,df=NULL,dfid=NULL){
  test=is.matrix(M)
  if(test){
    if(is.null(df)){
      result=met.instrength.single(M,df=df,dfid=dfid)
      return(result)
    }
    else{
      if(is.null(dfid)){warning("Argument dfid hasn't been declared. M and df are considered to be ordered exactly in the same way.")}
      result=met.instrength.single(M,df=df,dfid=dfid)
      return(result)      
    }

  }
  
  if(!is.null(attributes(M)$ANT)){
    if(attributes(M)$ANT=='ANT data stream group sampling single matrix'){
      
      if(!is.null(df)){
        if(!is.data.frame(df)){stop("Argument df must be a data frame when argument M is an outcome of perm.ds.grp ant function","\r")}
      }
      if(is.null(dfid)){warning("Argument dfid hasn't been declared. M and df are considered to be ordered exactly in the same way.")}
      result=lapply(M,function(x,df,dfid){
        r=met.instrength.single(x,df=df,dfid=dfid)
        attr(r,"permutation")=attributes(x)$permutation
        return(r)
      },df=df,dfid=dfid)      
      attr(result,'scan')=attributes(M)$scan
      attr(result,'ctrlf')=attributes(M)$ctrlf
      attr(result,'method')=attributes(M)$method
      attr(result,'ANT')=attributes(M)$ANT
      return(result)
    } 
    
    if(attributes(M)$ANT=="ANT data stream focal sampling single matrix"){
      
      if(!is.null(df)){
        if(!is.data.frame(df)){stop("Argument df must be a data frame when argument M is an outcome of perm.ds.grp ant function","\r")}
      }
      if(is.null(dfid)){warning("Argument dfid hasn't been declared. M and df are considered to be ordered exactly in the same way.")}
      result=lapply(M,function(x,df=df,dfid=dfid){
        r=met.instrength.single(x,df=df,dfid=dfid)
        attr(r,"permutation")=attributes(x)$permutation
        return(r)
      },df=df,dfid=dfid)   
      attr(result,'focal')=attributes(M)$focal
      attr(result,'ctrl')=attributes(M)$ctrl
      attr(result,'alters')=attributes(M)$alters
      attr(result,'method')=attributes(M)$method
      attr(result,'ANT')=attributes(M)$ANT
      return(result)
    }
    
    if(attributes(M)$ANT=="ANT link permutations single matrix"){
      
      if(!is.null(df)){
        if(!is.data.frame(df)){stop("Argument df must be a data frame when argument M is an outcome of perm.ds.grp ant function","\r")}
      }
      if(is.null(dfid)){warning("Argument dfid hasn't been declared. M and df are considered to be ordered exactly in the same way.")}
      result=lapply(M,function(x,df=df,dfid=dfid){
        r=met.instrength.single(x,df=df,dfid=dfid)
        attr(r,"permutation")=attributes(x)$permutation
        return(r)
      },df=df,dfid=dfid)   
      attr(result,'ANT')=attributes(M)$ANT
      return(result)
    }
    
    if(attributes(M)$ANT=='ANT data stream group sampling multiple matrices'){
      
      if(is.null(df)){
        result=lapply(M, function(x){
          r1=lapply(x, function(y){
            r2=met.instrength.single(y)
            attr(r2,'permutation')=attributes(y)$permutation
            return(r2)
          })
        })
        attr(result,'scan')=attributes(M)$scan
        attr(result,'ctrlf')=attributes(M)$ctrlf
        attr(result,'method')=attributes(M)$method
        attr(result,'ANT')=attributes(M)$ANT
        return(result)
      }
      if(is.null(dfid)){warning("Argument dfid hasn't been declared. M and df are considered to be ordered exactly in the same way.")}
      if(!is.null(df) & is.data.frame(df)){stop("Argument df must be a list of data frames of same length as the argument df input in function perm.ds.grp.","\r")}
      if(sum(unlist(lapply(seq_along(M), function(i,a){nrow(a[[i]][[1]])},a=M)))==nrow(df[[1]])){
        tmp=lapply(M, function(x){
          r1=lapply(x, function(y){
            r2=met.instrength.single(y)
          })
        })
        
        tmp=do.call(Map,c(c,tmp))
        
        result=lapply(seq_along(df), function(i,a,b){
          a[[i]]$instrength=b[[i]]
          return(a[[i]])
        },a=df, b=tmp)
        
        return(result)
      }
      else{
        #data fame manipulation
        if(!is.null(dfid)){
          dfid=df.col.findId(df[[1]],dfid)
          df=lapply(df,function(x){x=x[order(x[[dfid]]),]})
        }
        ldf=do.call('rbind',df)
        
        tmp=lapply(M, function(x){
          r1=lapply(x, function(y){
            r2=met.instrength.single(y)
          })
          
        })
        tmp=do.call(Map,c(c,tmp))
        result=lapply(seq_along(tmp), function(tmp,ldf,i){
          ldf$instrength=tmp[[i]]
          attr(ldf,'permutation')=i
          return(ldf)
        },tmp=tmp,ldf=ldf)
        attr(result,'scan')=attributes(M)$scan
        attr(result,'ctrlf')=attributes(M)$ctrlf
        attr(result,'method')=attributes(M)$method
        attr(result,'ANT')=attributes(M)$ANT
        return(result)
      }
    }
    
    if(attributes(M)$ANT=="ANT data stream focal sampling multiple matrices"){
      if(is.null(df)){
        result=lapply(M, function(x){
          r1=lapply(x, function(y){
            r2=met.instrength.single(y)
            attr(r2,'permutation')=attributes(y)$permutation
            return(r2)
          })
        })
        attr(result,'focal')=attributes(M)$focal
        attr(result,'ctrl')=attributes(M)$ctrl
        attr(result,'alters')=attributes(M)$alters
        attr(result,'method')=attributes(M)$method
        attr(result,'ANT')=attributes(M)$ANT
        return(result)
      }
      if(is.null(dfid)){warning("Argument dfid hasn't been declared. M and df are considered to be ordered exactly in the same way.")}
      if(!is.null(df) & is.data.frame(df)){stop("Argument df must be a list of data frames of same length as the argument df input in function perm.ds.grp.","\r")}
      if(sum(unlist(lapply(seq_along(M), function(i,a){nrow(a[[i]][[1]])},a=M)))==nrow(df[[1]])){
        tmp=lapply(M, function(x){
          r1=lapply(x, function(y){
            r2=met.instrength.single(y)
          })
        })
        
        tmp=do.call(Map,c(c,tmp))
        
        result=lapply(seq_along(df), function(i,a,b){
          a[[i]]$instrength=b[[i]]
          return(a[[i]])
        },a=df, b=tmp)
        
        return(result)
      }
      else{
        #data fame manipulation
        if(!is.null(dfid)){
          dfid=df.col.findId(df[[1]],dfid)
          df=lapply(df,function(x){x=x[order(x[[dfid]]),]})
        }
        ldf=do.call('rbind',df)
        
        tmp=lapply(M, function(x){
          r1=lapply(x, function(y){
            r2=met.instrength.single(y)
          })
          
        })
        tmp=do.call(Map,c(c,tmp))
        result=lapply(seq_along(tmp), function(tmp,ldf,i){
          ldf$instrength=tmp[[i]]
          attr(ldf,'permutation')=i
          return(ldf)
        },tmp=tmp,ldf=ldf)
        
        attr(result,'focal')=attributes(M)$focal
        attr(result,'ctrl')=attributes(M)$ctrl
        attr(result,'alters')=attributes(M)$alters
        attr(result,'ANT')=attributes(M)$ANT
        return(result)
      }
      
    }
    
    if(attributes(M)$ANT=="ANT link permutations multiple matrices"){
      if(is.null(df)){
        result=lapply(M, function(x){
          r1=lapply(x, function(y){
            r2=met.instrength.single(y)
            attr(r2,'permutation')=attributes(y)$permutation
            return(r2)
          })
        })
        attr(result,'ANT')=attributes(M)$ANT
        return(result)
      }
      if(is.null(dfid)){warning("Argument dfid hasn't been declared. M and df are considered to be ordered exactly in the same way.")}
      if(!is.null(df) & is.data.frame(df)){stop("Argument df must be a list of data frames of same length as the argument df input in function perm.ds.grp.","\r")}
      if(sum(unlist(lapply(seq_along(M), function(i,a){nrow(a[[i]][[1]])},a=M)))==nrow(df[[1]])){
        tmp=lapply(M, function(x){
          r1=lapply(x, function(y){
            r2=met.instrength.single(y)
          })
        })
        
        tmp=do.call(Map,c(c,tmp))
        
        result=lapply(seq_along(df), function(i,a,b){
          a[[i]]$instrength=b[[i]]
          return(a[[i]])
        },a=df, b=tmp)
        
        return(result)
      }
      else{
        if(!is.null(dfid)){
          dfid=df.col.findId(df[[1]],dfid)
          df=lapply(df,function(x){x=x[order(x[[dfid]]),]})
        }
        ldf=do.call('rbind',df)
        
        tmp=lapply(M, function(x){
          r1=lapply(x, function(y){
            r2=met.instrength.single(y)
          })
          
        })
        tmp=do.call(Map,c(c,tmp))
        result=lapply(seq_along(tmp), function(tmp,ldf,i){
          ldf$instrength=tmp[[i]]
          attr(ldf,'permutation')=i
          return(ldf)
        },tmp=tmp,ldf=ldf)
        
        attr(result,'ANT')=attributes(M)$ANT
        return(result)
      }
    }
  }
  
  if(!test & is.list(M)){
    if(is.null(df) & !is.null(dfid)){stop("Argument 'df' can't be NULL when argument 'dfid' isn't","\r")}
    
    if(is.null(df) & is.null(dfid)){
      result=lapply(M,met.instrength.single)
      return(result)
    }
    
    if(!is.null(df) & !is.data.frame(df) & is.list(df)){
      if(!is.null(dfid)){
        result=mapply(met.instrength.single,M,df=df,dfid=dfid,SIMPLIFY = F)
        return(result)
      }
      else{
        if(is.null(dfid)){warning("Argument dfid hasn't been declared. M and df are considered to be ordered exactly in the same way.")}
        result=mapply(met.instrength.single,M,df=df,SIMPLIFY = F)
        return(result) 
      }
      
    }
  }
  
  
}