shinyUI(
  navbarPage(
    "NYC Real Estate Explorer",
    id = "nav",
    theme = "bootstrap.css",
    tabPanel(
      'Interactive Map',
      sidebarLayout(
        fluid = T,
        mainPanel(
          width = 9,
          div(
            class='outer',
            
            tags$head(
              includeCSS('style.css')
            ),
            
            leafletOutput("map", width="100%", height="100%")
          )
        ),
        
        sidebarPanel(
          id = "controls",
          h3("Apartment finder"),
          width = 3,
          textOutput("remaining"),
          
          
          
          sliderInput(
            "price",
            label = "Budget:",
            width = "95%",
            min = min_price,
            max = max_price,
            step = 500,
            value = c(min_price,max_price)
          ),
          
          
          
          sliderInput(
            "ppsf",
            label = "Price per sf:",
            width = "95%",
            min = min_ppsf,
            max = max_ppsf,
            step = 2,
            value = c(min_ppsf,max_ppsf)
          ),
          
          
          
          checkboxGroupInput(
            "boro",
            label = "Boroughs:",
            inline = T,
            choices = list("Manhattan" = 'MANHATTAN',
                           "Brooklyn" = 'BROOKLYN',
                           "Queens" = 'QUEENS',
                           "Bronx" = 'BRONX',
                           "Staten-Island" = 'STATEN-ISLAND',
                           "All Boroughs" = 'ALL'),
            selected = c()
          ),
          
          
          
          checkboxGroupInput(
            "bed",
            label = "Bedrooms:",
            inline = T,
            choices = list("studio" = 0,
                           "1" = 1,
                           "2" = 2,
                           "3" = 3,
                           "4" = 4,
                           "5+" = 5),
            selected = c()
          ),
          
          
          
          sliderInput(
            "bath",
            label = "Bathrooms:",
            width = "95%",
            min = 0, 
            max = 5,
            step = 0.5,
            value = c(0,5)
          ),
          
          
          
          sliderInput(
            "sqft",
            label = "Size in sqft:",
            width = "95%",
            min = min_sqft,
            max = max_sqft,
            step = 100,
            value = c(min_sqft,max_sqft)
          ),
          
          
          
          selectizeInput(
            "lam",
            label = "Amenities:",
            multiple = T,
            choices = lam,
            selected = c('ANY')
          ),
          
          
          
          actionButton("submit", "Search!", icon = icon("search"))
        )
      )
    ),
    
    
    
    tabPanel(
      'Data discovery',
      sidebarLayout(
        fluid = T,
        mainPanel(
          width = 9,
          plotOutput("explore_plot", width = '100%', height = '700px')
        ),
        
        
        
        sidebarPanel(
          id = "controls_zip",
          width = 3,
          selectInput(
            'map_input',
            label = "Category:",
            width = "95%",
            choices = c(
              'Number of listings',
              'Average number of beds',
              'Average price per sqft',
              'Average price per bedroom',
              'Average size of listings',
              'Average size per bedroom'
            ),
            selected = 'Number of listings'
          ),
          
          
          
          checkboxGroupInput(
            "map_boro",
            label = "Boroughs:",
            inline = F,
            choices = list("Manhattan" = 'MANHATTAN',
                           "Brooklyn" = 'BROOKLYN',
                           "Queens" = 'QUEENS',
                           "Bronx" = 'BRONX',
                           "Staten-Island" = 'STATEN-ISLAND',
                           "All Boroughs" = 'ALL'),
            selected = c()
          )
        )
      )
    ),
    
    
    
    tabPanel(
      'About',
      
      tags$div(
        id="cite", 
        ('The purpose of this app is to visualize the NYC Real Estate data scraped from StreetEasy.com')
      ),
      
      tags$p(),
      
      tags$div(
        id="cite", 
        tags$em('NYC Data Science Academy Data Scrapping Project')
      ),
      
      tags$div(
        id="authors",
        tags$em('By: Joe Eckert and Jean-Francois Darre')
      )
    )
  )
)
