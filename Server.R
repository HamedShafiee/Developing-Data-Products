# start shinyServer
#standard <- function(x,mean,sd) {(x-mean)/sd}

shinyServer(
    function(input,output){
        output$distType<-renderPrint({input$distType})
        output$n<-renderPrint({input$n})
        output$mean<-renderPrint({input$mean})
        output$sd<-renderPrint({input$sd})
        output$range<-renderPrint({input$range})
        output$lowerrange<-renderPrint({input$range[[1]]})
        output$upperrange<-renderPrint({input$range[[2]]})
        
        
        #output$x<-renderPrint({rnorm(input$n,mean = input$mean,sd=input$sd)})
        #if(input$distType=="Noraml"){output$x<-renderPrint({rnorm(input$n,mean = input$mean,sd=input$sd)})}
        output$plot1<-renderPlot({
            set.seed(4321) 
            if(input$distType=="Normal"){x<-data.frame(rnorm(input$n,mean = input$mean,sd=input$sd))}
            if(input$distType=="Poison"){x<-data.frame(rpois(input$n,lambda = input$lambda))}
            if(input$distType=="Uniform"){x<-data.frame(runif(input$n,min = input$min,max = input$max))}
            ggplot(data=x,aes(x)) +
            geom_histogram(aes(y=..density..), colour="black", fill="white",bins = 25)+
            geom_density(alpha=.2, fill="blue")+
            xlab("random values") +
            ylab("density") + 
            labs(title=input$distributionTitle) +
            geom_vline(aes(xintercept=input$mean),color="red", linetype= 2 , size=1)+
            geom_vline(aes(xintercept=input$range[[1]]),color="blue", linetype= 2 , size=1)+
            geom_vline(aes(xintercept=input$range[[2]]),color="blue", linetype= 2 , size=1)
                                 })
        output$summary<-renderPrint({
            
            set.seed(4321) 
            if(input$distType=="Normal"){x<-data.frame(rnorm(input$n,mean = input$mean,sd=input$sd))}
            if(input$distType=="Poison"){x<-data.frame(rpois(input$n,lambda = input$lambda))}
            if(input$distType=="Uniform"){x<-data.frame(runif(input$n,min = input$min,max = input$max))}
            summary(x)})
        output$probability<-renderPrint({
        
            if(input$distType=="Normal"){probability<-pnorm(input$range[[2]],mean=input$mean,sd=input$sd)-pnorm(input$range[[1]],mean=input$mean,sd=input$sd)}
            if(input$distType=="Poison"){probability<-ppois(input$range[[2]],lambda =input$lambda)-ppois(input$range[[1]],lambda =input$lambda)}
            if(input$distType=="Uniform"){probability<-punif(input$range[[2]],min = input$min,max = input$max)-punif(input$range[[1]],min = input$min,max = input$max)}
            probability
            })
    }
)
