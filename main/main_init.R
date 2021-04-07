library(mlflow)
library(rjson)
library(log4r)

#Set the working Dir as the project folder and make sure your while running mlruns dir get genrated in the project folder only
work_dir <- "~/Documents/GitHub/mlflow_use_case"
setwd(work_dir)

# make sure for each run you change the exp name other it's will track the error exp name already exist in the API
experiment_name_="check_RUN_6"

# Create a new logger object to write the log/cat statments in the pipeline/code, So we can track the
# statements and track the code run info,error,debug,warn, fatal as per the user use case.
logger <- create.logger()
# Set the logger's file output.
# logfile(logger) <- 'base.log'
# Set the current level of the logger.
level(logger) <- 'INFO'
# Try logging messages with different priorities.
# debug(logger, 'A Debugging Message')
# info(logger, 'An Info Message')
# warn(logger, 'A Warning Message')
# error(logger, 'An Error Message')
# fatal(logger, 'A Fatal Error Message')


main_config_data <- fromJSON(file = "config/main_config.json")
leakomania_config_data <- fromJSON(file = "config/leakomania_config.json")
cloud_config_data <- fromJSON(file ="config/cloud_config.json")
# MlFlow client object
client_ <- mlflow_client()
# MlFlow Experiment object
experiment_ID <- mlflow_create_experiment(name = experiment_name_, client = client_)

# MlFlow Launches the MLflow user interface: Tracking UI lets you visualize,
# search and compare runs, as well as download run artifacts or metadata for analysis in other tools. 
mlflow_ui()

# Now iterating over the loop to track each run within the Exp and save the meterics and parameters and file to be stored.
for (peril in ls(main_config_data)){
  
  experiment_peril_id_ <- peril
  if (main_config_data[peril] == TRUE){
    config_node<- NULL
    
    # mlflow_rename_experiment(new_name = peril,client = client_)
    # set_client <- mlflow_set_experiment(experiment_name = experiment_name_)
    # Now creating the object of starts a new run.
    active_run_meta_data <- mlflow_start_run(experiment_id = experiment_ID ,client = client_,nested = TRUE)
    #Return Active run ID.
    active_experiment_run_uuid_ <- active_run_meta_data$run_id
    
    # Creating the log file path then save to Artifact folder in last.
    file_name <- paste(experiment_name_,experiment_peril_id_,"_base.log",sep ="")
    # Assign the file_path to the logger object
    logfile(logger) <- file_name
    
    # Print/Cat your statment in log file: (with logger object and message)
    info(logger=logger,message = '**********Execuation of code starts*******')
    exper_id_log = paste("Experiment ID:", toString(experiment_name_)," for Peril:",experiment_peril_id_,"Run ID: ",active_experiment_run_uuid_)
    info(logger=logger,message = exper_id_log)
    
    if (experiment_peril_id_ =='cloud'){
        config_node <- cloud_config_data
    }
    if (experiment_peril_id_ == 'leakomania'){
        config_node <- leakomania_config_data
    }
    for (p in ls(config_node)) {
      if (p %in% c("CSPs","senarios_variant_case_ID","senarios_variant_jurdication_ID")){
        
        # Adding the Parameters in the Active Run
        # Examples are params and hyperparams used for ML training, or constant dates and values used in an ETL pipeline. A param is a STRING key-value pair. 
        mlflow_log_param(p,paste(config_node[[p]], collapse=', '),run_id = active_experiment_run_uuid_,client = client_)
      }else{
        # Adding the Parameters in the Active Run
        # Examples are params and hyperparams used for ML training, or constant dates and values used in an ETL pipeline. A param is a STRING key-value pair.
        mlflow_log_param(p,config_node[[p]],run_id = active_experiment_run_uuid_,client = client_)
    }
  }
  
  # Logs a metric for a run. Metrics key-value pair that records a single float measure
  mlflow_log_metric(experiment_peril_id_, 1,run_id = active_experiment_run_uuid_,client = client_)
  mlflow_log_metric(experiment_peril_id_, 5,run_id = active_experiment_run_uuid_,client = client_)
  mlflow_log_metric(experiment_peril_id_, 2,run_id = active_experiment_run_uuid_,client = client_)
  mlflow_log_metric(experiment_peril_id_, 3,run_id = active_experiment_run_uuid_,client = client_)
  
  text = paste(toString(experiment_name_), ":", toString(experiment_peril_id_))
  info(logger = logger,message = text)
  info(logger=logger,message = '*******Execaution of code ends*******')
  # Log the file artifact 
  # Logs a specific file (like .CSV,.PNG,.log file) or directory as an artifact for a run
  mlflow_log_artifact(file_name,client = client_,run_id = active_experiment_run_uuid_,artifact_path = file.path('log4j'))
  
  # Terminates a run. Attempts to end the current active run
  mlflow_end_run(
    status = "FINISHED",
    client = client_,run_id = active_experiment_run_uuid_)
  }
}

# There are some other features which are not been used but can be useful as per the use case like:
# Tagging the run: mlflow_set_tag: mlflow_set_tag(key, value, run_id = NULL, client = NULL)
# Set Experiment Tag: mlflow_set_experiment_tag: mlflow_set_experiment_tag(key, value, experiment_id = NULL, client = NULL)
# And many more, you can go through the doc: https://www.mlflow.org/docs/latest/R-api.html#





