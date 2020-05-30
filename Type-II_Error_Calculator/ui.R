library(shiny)

shinyUI(fluidPage(

    # Application title
    titlePanel("Type-II Error Calculator - Two-Sided Known Variance"),

    # Sidebar with the distribution parameters
    sidebarLayout(
        sidebarPanel(
            numericInput("x_bar", "Please enter the observed mean on the sample",
                         value = 0, step = 0.01),
            numericInput("sigma^2", "Please enter the variance of the population",
                         value = 1, step = 0.01),
            numericInput("n", "Please enter the sample size",
                         value = 2, min = 1, step = 1),
            numericInput("alpha", "Please enter the significance level",
                         value = 0.05, min = 0, max = 1, step = 0.001),
            numericInput("realmean", "Please enter the real mean of the population",
                         value = 1, step = 0.01)
        ),
        

        # Show the Type-II Error
        mainPanel(
            h2("How This Works: "),
            h6("This is a caclulator for the type-II error in a two-sided test with
               known variance. The app is very stright forward.
               Just start putting all of the known parameters of the test in
               the side panel. The type-II error would be displayed below.
               Also, a plot would be done. This plot shows the two distributions.
               The type-II error is the area under the red curve that is between
               the two vertical lines."),
            h4("The Type-II error is: "),
            textOutput("error"),
            h4("The plot: "),
            plotOutput("plot")
        )
    )
))
