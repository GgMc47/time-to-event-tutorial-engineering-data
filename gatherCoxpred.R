gatherCoxpred<-function(fitCox,data,x,quantity="time",event="status"){#x list of expl vars
  val_list=list()
  N=100
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
  val_df=val_df[rep(seq_len(nrow(val_df)), each = N),] # need replicates for predicting cox
  val_df[event]=rep(1,nrow(val_df)) # events occurred
  mini=min(eval(parse(text=paste0(deparse(substitute(data)),sep="$",quantity)))) # -10% below minimum observed
  maxi=max(eval(parse(text=paste0(deparse(substitute(data)),sep="$",quantity)))) # +10% over maximum observed
  quantity_reps=seq(mini-0.1*mini, maxi+0.1*maxi, length.out=N) # sequence of quanity
  val_df[quantity]=rep(quantity_reps,length.out=nrow(val_df)) # replicate
  df = data.frame(x=quantity_reps) # quantity as x-values
  for(i in 1:(nrow(val_df)/N)){
    combination = paste0("Pred::",paste(val_df[i*N-(N-1),-which(names(val_df) %in% c(event,quantity))],collapse=","))
    low=i*N-(N-1)
    high=i*N
    pred_vals=val_df %>% slice(low:high)
    df[, ncol(df)+1] <- list(predict(fitCox,newdata=pred_vals,type="survival")) # Append new column
    colnames(df)[ncol(df)] <- combination
  }
  df_long = gather(df, key="combination", value="y", -1)
  return(df_long)
}