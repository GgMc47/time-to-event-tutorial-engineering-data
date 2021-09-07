gatherAFTpred<-function(fitAFT,data,x){#x list of expl vars
  val_list=list()
  for(var in x){
    var_i<-eval(parse(text=paste0(deparse(substitute(data)),sep="$",var)))
    vals = unique(var_i) 
    val_list <- append(val_list, list(vals)) #store
  }
  val_df<-expand.grid(val_list)
  colnames(val_df)<-x
  for(var in colnames(val_df)){ # factor variables turn into level, want to keep as character for labels
    var_i<-paste0(deparse(substitute(data)),sep="$",var)
    if(is.factor(eval(parse(text=var_i)))){ #if main data is factor
      val_df[var] = as.character(unlist(val_df[var])) # make character
    }
  }
  pct=seq(.99,.01,by=-.01)
  df = data.frame(y=pct)
  for(i in 1:nrow(val_df)){
    combination = paste0("Pred::",paste(val_df[i,],collapse=","))
    df[, ncol(df)+1] <- list(predict(fitAFT, newdata=val_df[i,], type='quantile', p=1-pct)) # Append new column
    colnames(df)[ncol(df)] <- combination
  }
  df_long = gather(df, key= "combination", value="x", -y)
  return(df_long)
}