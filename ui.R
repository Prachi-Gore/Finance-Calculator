img_src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuU0JfGtSbccNad2h-fQ9mO8hOelb9YunoIqna38iFxA&usqp=CAU&ec=48665701";


ui_ = fluidPage(
  # tags$head(
  #   tags$link(
  #     rel = "stylesheet", type = "text/css", href = "styles.css"
  #   )
  # ),
  tags$script(src="https://kit.fontawesome.com/3f46fed376.js"),
  tags$head(
    tags$style(
      HTML(".radio-inline{padding-left: 40px;padding-right:20px;transform: scale(1.25);}
      input[type=number] {
              -moz-appearance:textfield;
        }
        input[type=number]::{
              -moz-appearance:textfield;
        }
        input[type=number]::-webkit-outer-spin-button,
           input[type=number]::-webkit-inner-spin-button {
              -webkit-appearance: none;
              margin: 0;
           }
        #output_div{
        display:flex;
        }
           ")
    )
  ),
  sidebarLayout(
  sidebarPanel(style="background-color:#C7EA46;border:solid black 4px;width:700px;height:600px;margin-top:30px",
               radioButtons("radio",label = "",inline = TRUE,
                            choices = list("Present Value" = 1,
                                           "Future Value" = 2,
                                           "EMI" = 3),
                            selected = 3),
    
  # Create input fields for variables
  uiOutput("dynamic_ui")),
  
  mainPanel(
    
    tags$div(style = "margin-left:350px;width: 350px;margin-top:70px; border-radius:3px",
             #'file:/C:/shiny_dashboard/images/emi.png'
    tags$img(src = img_src,
             height = "250px",
             width = "250px",
             alt = "Image Loading...",style="display:flex;margin:auto;"),
    tags$h1("EMI Calculator",style="text-align:center"),
    tags$p("Calculate your personal loan, home loan, or car loan EMI with Finance Calculator.",style = "text-align:center;font-size: 18px; color: rgb(46, 139, 87);"))
    )
  ))

header = dashboardHeader(
  title = "Finance Calculator",
  tags$li(class="dropdown",tags$a(href="https://github.com/Prachi-Gore",icon("github"),"github",target="_blank")),
  tags$li(class="dropdown",tags$a(href="https://www.linkedin.com/in/prachi-gore-4772a11a5",icon("linkedin"),"LinkedIn",target="_blank")),
  tags$li(class="dropdown",tags$a(href="https://www.hackerrank.com/prachi_gore",icon("hackerrank"),"HackerRank",target="_blank"))
  )
sidebar <- dashboardSidebar(
  
  sidebarMenu(
    id = "tabs",
    menuItem(" Finance Calculator",tabName = "fc", icon = icon("calculator"))))
body <- dashboardBody(
  tabItems(
    tabItem("fc",ui_)))

ui = dashboardPage(skin = "green",
  header,
  sidebar,
  body,
  # title = "Financial Calculator",
  tags$head(
    title = "Financial Calculator",
    tags$style(
      "
      html, body, h1, h2, h3, h4, h5, h6, p, a, span, label, input, select, button, table {
        font-size: 18px;
      }
      
      
        
      "
    )
  )
)