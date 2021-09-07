gofplot<-function(fit, dist){ #fit is a survfit object, dist is one of the location-scale distributions to be checked
  if(dist=="lognormal"){
    plot(log(fit$time),qnorm(1-fit$surv),ylab="Inverse normal of survival",xlab="log(t)",main=dist)
    lines(log(fit$time),qnorm(1-fit$surv))
  } else if(dist=="loglogistic"){
    plot(log(fit$time),qlogis(1-fit$surv),ylab="Inverse logistic of survival",xlab="log(t)",main=dist)
    lines(log(fit$time),qlogis(1-fit$surv))
  } else if(dist=="weibull"){
    plot(log(fit$time),qextr(1-fit$surv),ylab="Inverse weibull of survival",xlab="log(t)",main=dist) 
    lines(log(fit$time),qextr(1-fit$surv))
  }
}