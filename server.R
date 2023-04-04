
library(shinyjs)
library(FinCal)
#effective to nominal
nominal_rate = function(eff_rate, m) {
  m* ((1 + eff_rate) ^ (1/m) - 1)
}
# nominal to effective
effective_rate = function(nom_rate, m) {
  (1 + (nom_rate/m)) ^ m - 1
}
sub_ui=function(output_label){tags$div(selectInput(inputId = "payable", label = "Interest Payable : ", choices = c("Yearly", "Half Yearly", "Monthly")),
                                       numericInput("rate", "Interest rate", value = 0.05, min = 0, max = 1, step = 0.01),
                                       numericInput("nper", "Number of periods", value = 5, min = 1, max = , step = 1),
                                       numericInput("pmt", "Amount", value = 0, min = 0, max = , step = 1),

                                       # Create a button to calculate the present value and accumulated value


                                       useShinyjs(),
                                       actionButton(style="background-color:#3BB143;color:white;",
                                                    onmouseover = "this.style.backgroundColor='#C7EA46'; this.style.color='black';",
                                                    onmouseout = "this.style.backgroundColor='#3BB143'; this.style.color='white';",
                                                    "calculate", "Calculate"),
                                       # Create output fields for present value and accumulated value
                                       tags$br(),
                                       tags$div(id="output_div",tags$strong(paste(output_label," is")),tags$strong(textOutput("result"),style="color:green;margin-left:6px;margin-right:6px"),
                                                # tags$pre(" ",style="background-color:#C7EA46;border:none;margin-right:-6px"),
                                                tags$i(class = "fa-solid fa-rupee-sign fa-beat ",style="margin-top:5px;"),
                                                style="margin-top:20px;display:none;")
                                       #verbatimTextOutput(value)


)}
server=function(input,output,session){
  
 
  
  output$dynamic_ui= renderUI({

    #Write conditional logic to update the output based on the selected radio button
    if (input$radio == 1) {

     return( column(width=8,sub_ui("Present Value")))
    } else if (input$radio == 2) {

     return(column(width=8,sub_ui("Future Value")))
    } else {
     return(
      column(width=8,selectInput(inputId = "time", label = "Payment at the... ", choices = c("End", "Begining" )),
      sub_ui("Monthly Installment"))
     )
    }
 })

  #Calculate the present value and accumulated value when the user clicks the button
  observeEvent(input$calculate, {
    result =reactive({ switch(input$radio,
                     "1" = switch(input$payable,
                                    "Yearly" =  pv(r = input$rate, n = input$nper, pmt = input$pmt, fv=0),
                                    "Half Yearly" =  pv(r = input$rate/2, n = 2*input$nper, pmt = input$pmt, fv = 0),
                                    "Monthly" =  pv(r = input$rate/12, n = 12*input$nper, pmt = input$pmt, fv = 0)),
                     "2" = switch(input$payable,
                                "Yearly" =  fv(r = input$rate, n = input$nper, pmt = input$pmt, pv=0),
                                "Half Yearly" =  fv(r = input$rate/2, n = 2*input$nper, pmt = input$pmt, pv = 0),
                                "Monthly" =  fv(r = input$rate/12, n = 12*input$nper, pmt = input$pmt, pv = 0)),
                     "3" = switch(input$time,
                                "End"=switch(input$payable,
                                             "Yearly" =  pmt(r = nominal_rate(input$rate,12)/12, n = 12*input$nper, pv = input$pmt, fv=0,type=0),
                                             "Half Yearly" =  pmt(r = nominal_rate(effective_rate(input$rate,2),12)/12, n = 12*input$nper, pv = input$pmt, fv = 0,type=0),
                                             "Monthly" =  pmt(r = input$rate/12, n = 12*input$nper, pv = input$pmt, fv = 0,type=0)#monthly interest given and monthly installment asked
                                             ),
                                "Begining"= switch(input$payable,
                                                    "Yearly" =  pmt(r = nominal_rate(input$rate,12)/12, n = 12*input$nper, pv = input$pmt, fv=0,type=1),
                                                    "Half Yearly" =  pmt(r = nominal_rate(effective_rate(input$rate,2),12)/12, n = 12*input$nper, pv = input$pmt, fv = 0,type=1),
                                                    "Monthly" =  pmt(r = input$rate/12, n = 12*input$nper, pv = input$pmt, fv = 0,type=1)#monthly interest given and monthly installment asked
                                )
    ))})

      output$result <- renderText(-round(result(), 2))
      shinyjs::show("output_div")
      shinyjs::addClass(selector = "#output_div", class = "myClass")

  })


}



 