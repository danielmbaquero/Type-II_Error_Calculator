library(shiny)

# Define the requiered server logic
shinyServer(function(input, output) {

    output$error <- renderText({
        #First calculate the mean standard error
        n <- input$n
        sigma <- sqrt(input$`sigma^2`)
        std_e <- sigma/sqrt(n)
        
        #Calculate bounds for non-rejection of null hypotesis
        alpha <- input$alpha
        mu0 <- input$x_bar
        mu <- input$realmean
        I <- c(alpha/2, 1 - alpha/2)
        q <- qnorm(I, mean = mu0, sd = std_e)
        
        #Calculate probabilities of type two error
        b1 <- pnorm(q[1], mu, sigma)
        b2 <- pnorm(q[2], mu, sigma)
        b <- b2 - b1
        b
    })
    
    output$plot <- renderPlot({
        ## Plot the observed distribution
        n <- input$n
        sigma <- sqrt(input$`sigma^2`)
        std_e <- sigma/sqrt(n)
        alpha <- input$alpha
        mu0 <- input$x_bar
        mu <- input$realmean
        I <- c(alpha/2, 1 - alpha/2)
        q <- qnorm(I, mean = mu0, sd = sigma)
        
        lb <- mu0 - 4*std_e
        ub <- mu0 + 4*std_e
        
        plot(seq(lb, ub, 0.01),
             dnorm(seq(lb, ub, 0.01), mean = mu0, sd = std_e), type = "l",
             main = "Type-II Error Plot",
             col = "blue",
             ylab = "Prob",
             xlab = "")
        abline(v = q)
        lines(seq(lb, ub, 0.01),
             dnorm(seq(lb, ub, 0.01), mean = mu, sd = sigma), col = "red")
        legend("topright", 
               c("Observed Distribution", "Real Distribution"),
               fill = c("blue", "red"))
    })

})
