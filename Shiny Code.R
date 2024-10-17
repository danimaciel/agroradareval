library(shiny)
library(plotly)
library(googlesheets4)
library(readxl)
library(fmsb)
library(rsconnect)


# Uploud the form

gs4_deauth()
form <- read_sheet("https://docs.google.com/spreadsheets/d/1NLbmfKsvCCbhehzdz6QQmMam6NbhlUUZaaNYIZjHdX4/edit?usp=sharing")
form <- as.data.frame(form)

# UI layout ----
ui <- navbarPage("AgroRadarEval", 
                 id = "main_nav",
                 
                 # Página 1
                 tabPanel("About",
                          tags$h1("AgroRadarEval"),
                          tags$h2("Transforming evaluation outcomes into high-impact R&D strategies"),
                          tags$hr(style = "border-top: 1px solid green;"),
                          tags$h3("What is"), tags$br(),
                          tags$text("AgroRadarEval is a pioneering, interactive tool designed to address theoretical, conceptual, and practical gaps related to the systematization of the use of evaluation results in agricultural R&D. It was built from a comprehensive literature review and aims to support leaders and managers in reflecting on the strengths and weaknesses of organizational capacities, culture, collaborations, processes, and communication practices that underpin the use of evaluation outcomes in agricultural R&D. This framework adopts a comprehensive and integrative evaluation approach, encompassing multiple aspects of agricultural research management and emphasizing the strategic use of evaluation evidence to guide research directions effectively."),
                          tags$br(), tags$br(), # Cria espaço entre parágrafos
                          tags$text("Aligned with the principles of Responsible Research and Innovation (RRI) and Responsible Research Assessment (RRA), AgroRadarEval is built on three key pillars of support: Evaluation Capacity Building (ECB), Impact-Oriented Evaluation Culture, and Reflexive Learning. These pillars are operationalized through eight interconnected dimensions: 1. Participation and Collaboration, 2. Skill Development, 3. Promotion of an Evaluation Culture, 4. Feedback and Continuous Adaptation, 5. Integration with Strategic Planning, 6. Monitoring of Recommendation Implementation, 7. Influences of the External Environment, and 8. Communication."),
                          tags$br(), tags$br(),
                          tags$h3("Dimensions' Details"),tags$br(),tags$br(),
                          
                          fluidRow(
                            column(12,
                                   tags$a(href = "https://drive.google.com/file/d/1M_6tX0T2xo2swWkxvB2hu6Wy-wffUli_/view?usp=drive_link",
                                          target = "_blank",
                                          tags$image(src = "agroradareval.jpg", width = "50%", style = "display: block; margin: auto;"))
                                   
                                   
                            )
                          ),tags$br(),
                          
                          fluidRow(
                            column(12,
                                   tags$b("Participation and Collaboration:"),tags$text(" As proposed by Labin et al., the ECB model should actively and continuously involve all stakeholders in the evaluation process. This includes not only the evaluation team but also managers, program staff, program beneficiaries, and other stakeholders. Active participation and collaboration can promote the ownership of evaluation results and increase the likelihood of their use. In this sense, this is the element that enables the identification of likely demands for use by each involved actor. Directly associated with the concepts: Empowerment Evaluation and Practical Participatory Collaborative Evaluation.
")
                                   
                                   
                            )
                          ),tags$br(),
                          
                          
                          fluidRow(
                            column(12,
                                   tags$b("Competency Development:"), tags$text(" Implementing the strategies proposed by Preskill and Boyle (such as training, technical assistance, coaching, or mentoring) is essential to develop the necessary competencies to perform and use evaluations. This element includes the structure proposed by Labin et al. concerning needs (identification of the main demands for training and the entire arrangement for its realization). Directly associated with the concept of Learning-Centered Evaluation.

")
                                   
                                   
                            )
                          ),tags$br(),
                          
                          fluidRow(
                            column(12,
                                   tags$b("Promotion of an Evaluation Culture:"), tags$text(" This element is directly associated with strategies for developing an evaluative process to seek the establishment of a new mindset. This is an aggregating element concerning evaluation. It seeks to promote an organizational culture that values evaluation and evidence-based decision-making. This includes creating spaces for dialogue and discussion about evaluation results, as well as forming communities of practice that promote the sharing of knowledge and experiences in evaluation. Associated with the concepts of Utilization-Focused Evaluation (UFE) and Context-Sensitive Evaluation.
.")
                                   
                                   
                            )
                          ),tags$br(),
                          
                          fluidRow(
                            column(12,
                                   tags$b("Feedback and Continuous Adaptation:"),tags$text(" Includes mechanisms for providing feedback on evaluation results and adapting the evaluation process based on this feedback. This is crucial to ensure that the evaluation is always responding to the needs and priorities of stakeholders and to promote continuous learning and improvement. Associated with the concept of Developmental Evaluation.
.")
                                   
                                   
                            )
                          ),tags$br(),
                          
                          fluidRow(
                            column(12,
                                   tags$b("Integration with Strategic Planning:"), tags$text("	The ECB process focused on use must be integrated with the institution's strategic planning. This means that the results of the evaluations should be used to guide the institution's strategy and planning, and that the ECB process should be aligned with the strategic objectives and priorities of the institution, to contribute, especially, to the PD&I management process. Associated with the concept of Practical Policy Evaluation.
.")
                                   
                                   
                            )
                          ),tags$br(),
                          
                          
                          fluidRow(
                            column(12,
                                   tags$b("Monitoring of Recommendation Implementation:"), tags$text(" After the completion of the impact assessment, it is important to closely monitor the implementation of the resulting recommendations from the evaluative process. This ensures that the proposed actions and decisions are effectively put into practice and that any challenges or obstacles are identified and addressed appropriately. Continuous monitoring also helps ensure that the improvements and changes resulting from the evaluation are effective and contribute to the effective management of PD&I. Associated with Interactive Evaluation.
.")
                                   
                                   
                            )
                          ),tags$br(),
                          
                          fluidRow(
                            column(12,
                                   tags$b("External Environment:"), tags$text(" As a strategic element, the external environment influences the decisions and operations of agricultural P&D institutions. Factors such as public policies, technological trends, market demands, affirmative agendas, critical issues related to productivity (such as climate change), and socioeconomic issues, and stakeholder pressures can impact both the direction of research and the acceptance and application of the results of evaluations. Associated with the concepts: Responsive Evaluation; Situational Analysis
.")
                                   
                                   
                            )
                          ),tags$br(),
                          
                          fluidRow(
                            column(12,
                                   tags$b("Communication:"), tags$text(" This element is cross-cutting. It occurs throughout the process and is the basis for use to occur. It specifically addresses the strategies, channels, and practices related to the dissemination and sharing of evaluation results with stakeholders. It seeks to ensure that the evaluation results are effectively communicated, understood, and used by the various stakeholders. In this sense, communication consists of making the evaluation results accessible, understandable, and actionable, providing clear and targeted messages. Associated with the concepts: Transparent Evaluation and Knowledge Translation
.")
                                   
                                   
                            )
                          ),tags$br(),
                          
                          
                 ),
                 
                 #Página Dimensões e Perguntas
                 tabPanel("Pillars, Dimensions and Questions", 
                          fluidPage(
                            # título e subtítulo
                            tags$h1("AgroRadarEval"), 
                            tags$h2("Transforming evaluation outcomes into high-impact R&D strategies"),
                            tags$hr(style = "border-top: 1px solid green;"),
                            tags$h3("Pillars and Dimensions"),
                            tags$text("Each one of the three pillars are related to a dimension. In this sense we present below how each pillar is structured based on its corresponding dimensions."),
                            
                            fluidRow(
                              column(12,
                                     tags$a(href = "https://drive.google.com/file/d/1tEm00E6FvzNNigmmsC2_biWO-YWwWZi2/view?usp=sharing",
                                            target = "_blank",
                                            tags$image(src = "agroradareval_structure.jpg", width = "70%", style = "display: block; margin: auto;"))
                                     
                                     
                              )
                            ),tags$br(),
                            tags$h3("Dimensions and the associated questions"),
                            tags$text("To operationalize AgroRadarEval, we developed 94 affirmative questions across all dimensions. Below, you will find a detailed relationship between each dimension and its respective questions, providing an overview of the evaluated elements."),
                            uiOutput("dimensions_buttons"),  # botões das dimensões
                            uiOutput("questions_output")      # perguntas-afirmativas relacionadas
                          )
                 ),
                 
                 tabPanel("How it works", 
                          fluidPage(
                            # título e subtítulo
                            tags$h1("AgroRadarEval"), 
                            tags$h2("Transforming evaluation outcomes into high-impact R&D strategies"),
                            tags$hr(style = "border-top: 1px solid green;"),
                            tags$h3("Understanding how to use AgroRadarEval"),tags$br(),
                            HTML("AgroRadarEval is a framework developed with theoretical and conceptual references specifically from the fields of 'research evaluation' and 'evaluation of programs and public policies'. It is designed to align with the paradigms of Responsible Research and Innovation (RRI) and Responsible Research Assessment (RRA). By integrating RRI and RRA principles, AgroRadarEval emphasizes the importance of societal engagement, sustainability, ethical acceptability, and anticipatory governance in agricultural research and development, ensuring that its outcomes are beneficial for society and the environment. <br><br>
         It consists of eight distinct dimensions, each with specific variables and questions for a usefull evaluation. To operationalize AgroRadarEval, an electronic form using Google Forms was developed, which facilitates the collection of structured data in an accessible and efficient manner. This form can be accessed through the link: <a href='https://forms.gle/KHeRB2VuX5nYVNgW9', target = blank>https://forms.gle/KHeRB2VuX5nYVNgW9</a>.<br><br>
         Once the data is collected by the form, it is automatically integrated into the RStudio environment. This integration allows for the application of quantitative assessment models, which are transformed into visual representations through the Shiny package (POSIT.CO, 2023). Consequently, the results are presented graphically, allowing for an intuitive and visually appealing analysis.<br><br>
         The quantitative approach adopted in AgroRadarEval consolidates the responses of different actors from the same institution, resulting in a representative average for each organization. This means that although multiple individuals within an institution can complete the form, their contributions are combined to form a single score that reflects the collective performance of the institution.<br><br>
         At the end of the process, after answering all relevant questions for each evaluated dimension, a radar chart is generated. This chart presents the organization's performance in the various dimensions adopted by the framework, providing a comparison between the values achieved by the organization and the established benchmarks - expected average and maximum values. This graphical representation method allows for an intuitive analysis, facilitating the identification of areas where the organization exceeds, meets, or falls short of the established performance standards.<br><br>
         To check the results obtained by their institution, users can consult the 'Evaluation Radar' page of this website, after filling out the AgroRadarEval form.<br><br><b>Important:</b> When analyzing the results, considering both the average and maximum values is crucial. These values, shown below, can help you to understand the position of your institution.<br>")
                          ),
                          # Tabela HTML
                          fluidPage(tags$h3("Average and Maximum Values"),
                                    HTML('
           <table style="width:100%", style = "display: block; margin: auto;">
              <tr>
                <th>Dimension</th>
                <th>Average Value</th> 
                <th>Maximum Value</th>
              </tr>
              <tr>
                <td>Participation and Collaboration</td>
                <td>35</td> 
                <td>70</td>
              </tr>
              <tr>
                <td>Skill Development</td>
                <td>30</td> 
                <td>60</td>
              </tr>
              <tr>
                <td>Promotion of an Evaluation Culture</td>
                <td>32.5</td> 
                <td>65</td>
              </tr>
              <tr>
                <td>Feedback and Continuous Adaptation</td>
                <td>25</td> 
                <td>50</td>
              </tr>
              <tr>
                <td>Integration with Strategic Planning</td>
                <td>22.5</td> 
                <td>45</td>
              </tr>
              <tr>
                <td>Monitoring of Recommendation Implementation</td>
                <td>27.5</td> 
                <td>55</td>
              </tr>
              <tr>
                <td>External Environment</td>
                <td>27.5</td> 
                <td>55</td>
              </tr>
              <tr>
                <td>Communication</td>
                <td>35</td> 
                <td>70</td>
              </tr>
            </table>'
                                    )
                                    
                          ),tags$br(),
                          # Tabela HTML 2
                          fluidPage(tags$h5(tags$i("Completing these dimensions must be, a priori, the institution's discretion regarding who and how many individuals to involve. However, to support the selection of actors, six characteristics are presented described in table below")),
                                    tags$h3("Characteristics of the profile to complete AgroRadarEval"),tags$br(),
                                    HTML('
           <table style="width:100%", style = "display: block; margin: auto;">
              <tr>
                <th>Feature</th>
                <th>Description</th> 
              </tr>
              <tr>
                <td>Knowledge of organizational processes</td>
                <td>Understanding of all internal processes of the organization, especially in areas of Research, Development and Innovation.</td> 
              </tr>
              <tr>
                <td>Familiarity with internal assessment practices</td>
                <td>Understanding of how assessments are carried out within the organization, including metrics and indicators used.</td> 
              </tr>
              <tr>
                <td>Strategic vision of RD&I</td>
                <td>Understanding of the organization s RD&I objectives, as well as the strategies designed to achieve them, including the construction of new RD&I programs and projects.</td> 
              </tr>
              <tr>
                <td>Knowledge of trends in the agricultural sector</td>
                <td>Understanding of trends and challenges in the agricultural sector that can influence RD&I practices.</td> 
              </tr>
              <tr>
                <td>Critical evaluation capacity</td>
                <td>Ability to critically evaluate internal practices and the organizations position regarding the use of evaluation evidence.</td> 
              </tr>
              <tr>
                <td>Familiarity with concepts of impact and innovation in research</td>
                <td>Understanding how research and its evidence can generate impact and innovation in the context of the organization.</td> 
              </tr>
            </table>'
                                    ),
                                    tags$br(),
                                    
                          )),
                 
                 # Página Evaluation Radar 
                 tabPanel("Evaluation Radar", 
                          fluidPage(
                            # título e subtítulo
                            tags$h1("AgroRadarEval"), 
                            tags$h2("Transforming evaluation outcomes into high-impact R&D strategies"),
                            tags$hr(style = "border-top: 1px solid green;"),
                            
                            # Sidebar Layout
                            sidebarLayout(
                              sidebarPanel(
                                # Inputs
                                selectInput(inputId = "selected_institutions",
                                            label = "Choose institution:",
                                            choices = as.character(form$`Instituition Name`),
                                            multiple = FALSE,
                                            selectize = TRUE),
                                tags$h6(HTML("Please wait a few minutes for your institution to appear. If it doesn't, contact us.")),
                                downloadButton("Baixar_dados", "Dowload data")
                              ),
                              mainPanel(
                                # Outputs
                                plotlyOutput(outputId = "radarPlot"),
                                uiOutput(outputId = "dados")
                              )
                            )
                          )
                 ),
                 
                 # Página de Contato
                 tabPanel("Contact",
                          id = "contact",
                          tags$h1("AgroRadarEval"),
                          tags$h2("Transforming evaluation outcomes into high-impact R&D strategies"),
                          tags$hr(style = "border-top: 1px solid green;"),
                          tags$h3("Contact us"),
                          tags$h4("Daniela Maciel"),
                          tags$text("daniela.maciel@embrapa.br"),tags$br(),
                          tags$link("https://github.com/danimaciel")
                          
                          
                 )
)



carregarDados <- function() {
  gs4_deauth()
  form <- read_sheet("https://docs.google.com/spreadsheets/d/1NLbmfKsvCCbhehzdz6QQmMam6NbhlUUZaaNYIZjHdX4/edit?usp=sharing")
  form <- as.data.frame(form)
  form2 <- data.frame(apply(form[, 5:98], 2, function(x) as.numeric(as.character(x))))
  return(form2)
}

carregarDados2 <- function() {
  gs4_deauth()
  form <- read_sheet("https://docs.google.com/spreadsheets/d/1NLbmfKsvCCbhehzdz6QQmMam6NbhlUUZaaNYIZjHdX4/edit?usp=sharing")
  form <- as.data.frame(form)
  return(form)
}

mean2 <- function(x) {
  numeric_values <- suppressWarnings(as.numeric(as.character(x)))
  valid_numeric_values <- numeric_values[!is.na(numeric_values)]
  mean(valid_numeric_values, na.rm = TRUE)
}

# Server logic to set up the inputs and outputs ----
server <- function(input, output, session) {
  valores <- reactiveValues(form = NULL, form2 = NULL)
  auto_invalidate <- reactiveTimer(60000)
  observe({
    auto_invalidate()
    valores$form2 <- carregarDados()
    valores$form <- carregarDados2()
  })
  
  form_dados <- eventReactive(input$selected_institutions,{
    
    v1 <- 0
    v2 <- 0
    v3 <- 0
    v4 <- 0
    v5 <- 0
    v6 <- 0
    v7 <- 0
    v8 <- 0
    
    gs4_deauth()
    form <- read_sheet("https://docs.google.com/spreadsheets/d/1NLbmfKsvCCbhehzdz6QQmMam6NbhlUUZaaNYIZjHdX4/edit?usp=sharing")
    form <- as.data.frame(form)
    form2 <- data.frame(apply(form[, 5:98], 2, function(x) as.numeric(as.character(x))))
    
    
    form_dados <- read_excel("form_dados_media_maximo_english.xlsx")
    
    institutions <- input$selected_institutions 
    institutions_tamanho <- length(which(institutions == form$`Instituition Name`))
    if(institutions_tamanho == 1){
      linha <- which(institutions == form$`Instituition Name`) 
      v1 <- sum(as.numeric(unlist(valores$form[linha, 5:18])))
      v2 <- sum(as.numeric(unlist(valores$form[linha, 19:30])))
      v3 <- sum(as.numeric(unlist(valores$form[linha, 31:43])))
      v4 <- sum(as.numeric(unlist(valores$form[linha, 44:53])))
      v5 <- sum(as.numeric(unlist(valores$form[linha, 54:62])))
      v6 <- sum(as.numeric(unlist(valores$form[linha, 63:73])))
      v7 <- sum(as.numeric(unlist(valores$form[linha, 74:84])))
      v8 <- sum(as.numeric(unlist(valores$form[linha, 85:98])))
      
    } else if (institutions_tamanho > 1) {
      linha <- which(form$`Instituition Name` == institutions) 
      form2 <- apply(form2, 2, as.numeric)
      
      dados_instituicao <- form2[linha, ] # Assume que form2 já está convertido para numérico
      
      # Inicializa as somas para cada dimensão
      soma_dimensoes <- numeric(8)
      
      # Define os intervalos das colunas para cada dimensão
      intervalos <- list(1:14, 15:26, 27:39, 40:49, 50:58, 59:69, 70:80, 81:94) 
      
      # Calcula a soma para cada dimensão
      for (i in seq_along(intervalos)) {
        soma_dimensoes[i] <- sum(dados_instituicao[, intervalos[[i]]], na.rm = TRUE)
      }
      
      # Calcula a média dessas somas dividindo pelo número total de entradas (linhas) para a instituição
      numero_de_entradas <- length(linha)
      medias_dimensoes <- soma_dimensoes / numero_de_entradas
      
      # Agora medias_dimensoes contém a média para cada dimensão para instituições com múltiplas entradas
      
      v1 <- medias_dimensoes[1]
      v2 <- medias_dimensoes[2]
      v3 <- medias_dimensoes[3]
      v4 <- medias_dimensoes[4]
      v5 <- medias_dimensoes[5]
      v6 <- medias_dimensoes[6]
      v7 <- medias_dimensoes[7]
      v8 <- medias_dimensoes[8]
    }
    
    
    form_dados$User_Data <- as.numeric(c(v1,v2,v3,v4,v5,v6,v7,v8))
    print(form_dados$User_Data)
    return(form_dados)
    
  })
  
  # Lista de perguntas por dimensão
  questions <- list(
    "Participation and Collaboration" = c("The institution identifies and maps all relevant stakeholders for the assessment", "All identified stakeholders are actively involved throughout the assessment process", "The institution effectively identifies and documents the needs and interests of each stakeholder", "The institution has effective mechanisms to ensure the active participation of all interested parties in the evaluation", "Approaches to interacting with stakeholders are determined and adapted as needed by the institution", "The institution has well-defined strategies to prepare and disseminate teaching materials on assessment to interested parties", "The institution maintains an adequate frequency of meetings (in-person or virtual) to discuss the evaluation with interested parties", "Stakeholder interactions and contributions are effectively documented during the assessment process by the institution", "There is a formal and regular channel where the institution receives feedback from interested parties after interactions", "The institution clearly and openly communicates the methodologies and criteria used in evaluations", "The institution ensures that all data and information used in assessments are accessible and understandable to interested parties", "The institution documents and uses the theory of change to guide its assessment activities", "The institution identifies and addresses potential points of resistance that may affect the path to impact", "The institution evaluates and improves the quality of interactions with stakeholders to ensure contributions to the impact path"),
    "Skill Development" = c("The institution effectively identifies and maps the main demands and needs for evaluation training", "The institution has a process for selecting or defining the appropriate space to carry out training", "The profiles of training participants or beneficiaries are clearly defined", "The number of human resources needed for assessments is adequate", "The institution carries out assessments to determine the appropriate number of human resources needed for training", "The institution assesses the competence acquired by participants after the training", "The institution adopts specific training strategies, such as training, technical assistance, coaching and mentoring", "Trainings are carried out with adequate frequency and regularity", "The institution offers a feedback mechanism after training, allowing participants to provide opinions on the effectiveness and relevance of the training", "The institution evaluates and improves the capacity of those involved to understand and apply the theory of change", "The institution uses or has developed recognized methods to evaluate the impact of capabilities on the path to impact", "The institution employs transparent and recognized approaches to adjust its activities and ensure alignment with the desired impact path"),
    "Promotion of an Evaluation Culture" = c("The institution effectively aligns its strategy with the promotion of a culture of evaluation", "The institution uses appropriate mechanisms and platforms to create spaces for discussion about evaluations and their results", "The institution systematically documents the process and results of assessments, ensuring that they are centered on users' needs", "The institution effectively shares the results of the evaluations with its potential users", "The institution has a well-established institutional process that connects assessment to R&D management and the institution's overall strategy", "The institution adequately systematizes and standardizes its evaluation process", "The institution actively encourages the formation of communities of practice focused on evaluation", "The institution establishes effective recognition mechanisms for successful evaluation practices", "The institution offers regular training to train members on the importance and practices of assessment", "The institution promotes transparency as a core value in its assessment practices", "The institution provides open and unrestricted access to evaluation reports and results, ensuring their transparency", "The institution evaluates and promotes internal awareness about the importance of the path to impact", "Lessons learned are integrated into daily organizational practices to reinforce the impact path"),
    "Feedback and Continuous Adaptation" = c("The institution has effective mechanisms to collect feedback on assessment results", "The institution efficiently identifies key actors to provide feedback", "The institution proactively uses the feedback received to define its evaluation agendas and priorities", "The institution has clear criteria for analyzing and selecting relevant feedback", "The institution requests feedback on the assessment process with appropriate frequency", "The institution has established processes that ensure feedback is effectively incorporated into assessment practices", "The institution communicates in a transparent and effective way to interested parties the changes or adaptations made based on the feedback received", "The institution transparently communicates the justifications for any changes or adaptations made based on the feedback received", "The institution tracks the impact of feedback received on its assessment activities", "The institution demonstrates the ability to adapt when new information relevant to the impact path emerges"),
    "Integration with Strategic Planning" = c("The institution has a clear strategy to incorporate evaluation into strategic planning, especially in relation to R&D", "Evaluators maintain effective interaction and dialogue with the institution's strategic managers", "Evaluators play an active and influential role in the selection of strategic projects", "The institution documents and directs assessment results effectively to users", "The institution ensures that assessment results are promptly shared with potential users", "The institution has specific and effective KPIs related to the assessment process, and they are used and updated regularly", "The results of the assessments have a significant impact on the readjustment of the institution's strategies and plans", "The path to impact is considered in the institution's strategic discussions", "Strategic decisions are informed or modified by the path to impact"),
    "Monitoring of Recommendation Implementation" = c("The institution has an established and efficient system or process for monitoring recommendations after assessment", "Assessment recommendations are regularly reviewed, and your progress is consistently tracked", "The institution uses clear and effective metrics or indicators to evaluate the implementation of recommendations", "The institution receives constant feedback from key stakeholders on the progress and effectiveness of implemented recommendations", "The institution has effective strategies to deal with challenges or obstacles encountered during the implementation of recommendations", "The monitoring process is documented, reviewed and updated periodically", "The institution has robust mechanisms to adapt or revise recommendations based on feedback or changes in context", "The assessment team effectively incorporates feedback collected from monitoring into its future actions or assessments", "During the monitoring process, there is continuous and productive collaboration between the evaluation team and RD&I management", "The institution evaluates the effect of implemented recommendations on the path to impact", "The institution uses indicators to monitor progress along the path to impact and these are reviewed periodically"),
    "External Environment" = c("The institution identifies and effectively engages with its main stakeholders", "The institution has a systematic and effective process to monitor and respond to the external context, especially in relation to the productive sector", "The institution is aware of and adequately addresses the main public policies that impact its R&D activities", "The institution remains up to date and proactive in relation to technological trends and innovations in the agricultural sector", "There is a robust process at the institution to evaluate and align market demands with R&D objectives and activities", "The institution takes significant measures to ensure sensitivity to affirmative agendas and address critical issues", "The institution has an effective mechanism to monitor and respond to socioeconomic issues that may impact its R&D activities", "The institution effectively collects and integrates stakeholder feedback into its R&D activities and decisions", "The institution maintains effective strategic partnerships or collaborations with other players in the agricultural sector to address common challenges and share insights", "The institution analyzes and responds to external factors that can modify the path to impact", "The institution has processes in place to assess and respond to external changes relevant to its impact assessment activities"),
    "Communication" = c("The institution adopts effective strategies to communicate assessment results", "The institution identifies and uses the most effective communication channels for different groups of stakeholders", "The institution's communication of assessment results is effective and clear", "The institution adopts a differentiated communication strategy, taking into account the profile of the target audience", "The institution guarantees adequate access and understanding of results by directly interested parties", "The results of the assessments are made available by the institution in appropriate and accessible means/platforms", "The institution reviews and improves its communication practices based on feedback from stakeholders", "There are effective mechanisms in place in the institution to measure the effectiveness of communication and the level of engagement of interested parties with the published results", "Communication of assessment results by the institution occurs with an adequate and effective frequency", "The institution deals proactively and effectively with feedback and questions that arise after the results are released", "The institution ensures that the language and format of assessment results are transparent and easily understood by all interested parties", "The institution is committed to communicating both successes and challenges or failures identified in the evaluations, ensuring total transparency", "The institution adopts strategies to communicate the impact path to stakeholders", "The institution collects and uses feedback to improve the clarity and usefulness of its communications about the path to impact")
  )
  
  # Renderiza os botões para cada dimensão
  output$dimensions_buttons <- renderUI({
    lapply(names(questions), function(dimension) {
      actionButton(inputId = paste0("button_", gsub(" ", "_", dimension)), label = dimension, width = "100%", style = "margin-bottom: 5px;")
    })
  })
  
  # Renderiza as perguntas com base no botão clicado
  lapply(names(questions), function(dimension) {
    observeEvent(input[[paste0("button_", gsub(" ", "_", dimension))]], {
      output$questions_output <- renderUI({
        tagList(
          h4(dimension),
          HTML(paste0("<ul>", paste0("<li>", questions[[dimension]], "</li>", collapse = ""), "</ul>"))
        )
      })
    })
  })
  
  # Render the radar chart ----
  output$radarPlot <- renderPlotly({
    
    # Plot with plotly
    p <- plot_ly(type = 'scatterpolar', fill = 'toself', mode = 'lines') %>%
      add_trace(data = form_dados(), r = ~100, theta = ~Dimension, name = 'Maximum', 
                fillcolor = 'rgba(0, 0, 0, 0)') %>%
      add_trace(data = form_dados(), r = ~Average_Normalized, theta = ~Dimension, name = 'Average', 
                fillcolor = 'rgba(0, 0, 0, 0)') %>%
      add_trace(data = form_dados(), r = ~User_Data*Weight, theta = ~Dimension, name = 'Institution', 
                fillcolor = 'rgba(0, 0, 0, 0)') %>%
      layout(polar = list(radialaxis = list(visible = TRUE, range = c(0, 100))))
    
    return(p)
    
  })
  
  
  output$dados <- renderUI({
    estilos <- tags$style(HTML("
        .destaque { color: green; } 
        .melhor { color: purple; }"))
    
    indice <- which(form$`Instituition Name` == input$selected_institutions)
    vals <- apply(valores$form2[indice,], 2, mean2)
    destaques_sub <- na.omit(vals >= 3)
    destaques <- na.omit(colnames(valores$form2))[destaques_sub]
    destaques <- gsub("\\.", " ", destaques)
    melhorar_sub <- na.omit(vals < 3)
    melhorar <- na.omit(colnames(valores$form2))[melhorar_sub]
    melhorar <- gsub("\\.", " ", melhorar)
    
    dimensoes <- c("Participation and Collaboration", "Skill Development", "Promotion of an Evaluation Culture", "Feedback and Continuous Adaptation", "Integration with Strategic Planning", "Monitoring of Recommendation Implementation", "External Environment", "Communication")
    dimensoes_destaques <- rep(dimensoes, c(14, 12, 13, 10, 9, 11, 11, 14))[destaques_sub]
    dimensoes_melhorar <- rep(dimensoes, c(14, 12, 13, 10, 9, 11, 11, 14))[melhorar_sub]

    # Saída HTML para Destaques
    htmlOutput <- tagList(estilos, tags$h2(class = "destaque", "Highlights"))
    for (dimensao in unique(dimensoes_destaques)) {
      htmlOutput <- tagList(htmlOutput,
                            tags$h4(dimensao),
                            tags$ul(lapply(destaques[dimensoes_destaques == dimensao], function(destaque) {
                            tags$li(destaque)
                            }))
      )
    }
    
    
    # Adicionando a seção Melhorar
    htmlOutput <- tagList(htmlOutput, estilos, tags$h2(class = "melhor", "Areas for improvement"))
    for (dimensao in unique(dimensoes_melhorar)) {
      htmlOutput <- tagList(htmlOutput,
                            tags$h4(dimensao),
                            tags$ul(lapply(melhorar[dimensoes_melhorar == dimensao], function(melhorar) {
                              tags$li(melhorar)
                            }))
      )
    }
    
    return(htmlOutput)
    
  })
  
  output$Baixar_dados <- downloadHandler(
    filename = function() {
      paste0("data_", input$selected_institutions, ".csv")
    },
    content = function(file) {
      dados_para_baixar <- form_dados() 
      
      # Calcula os valores multiplicados pelo peso
      dados_para_baixar$Weighted_User_Data <- with(dados_para_baixar, User_Data * Weight)
      
      # Escreve o dataframe no arquivo
      write.csv(dados_para_baixar, file, row.names = FALSE)
    }
  )
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)

