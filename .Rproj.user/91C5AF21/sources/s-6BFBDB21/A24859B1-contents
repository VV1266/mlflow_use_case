
library(mlflow)
library(rjson)
library(log4r)

work_dir <- "~/Documents/GitHub/mlflow_use_case"
setwd(work_dir)


experiment_name_="check_RUN_6"
# Create a new logger object with create.logger().
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

# exeriment_id_ = "cloud"

main_config_data <- fromJSON(file = "config/main_config.json")
leakomania_config_data <- fromJSON(file = "config/leakomania_config.json")
cloud_config_data <- fromJSON(file ="config/cloud_config.json")
client_ <- mlflow_client()
experiment_ID <- mlflow_create_experiment(name = experiment_name_, client = client_)
mlflow_ui()

for (peril in ls(main_config_data)){
  experiment_peril_id_ <- peril
  
  if (main_config_data[peril] == TRUE){
    config_node<- NULL
    # mlflow_rename_experiment(new_name = peril,client = client_)
    # set_client <- mlflow_set_experiment(experiment_name = experiment_name_)
    active_run_meta_data <- mlflow_start_run(experiment_id = experiment_ID ,client = client_,nested = TRUE)
    active_experiment_run_uuid_ <- active_run_meta_data$run_id
    file_name <- paste(experiment_name_,experiment_peril_id_,"_base.log",sep ="")
    logfile(logger) <- file_name
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
        mlflow_log_param(p,paste(config_node[[p]], collapse=', '),run_id = active_experiment_run_uuid_,client = client_)
      }else{
        mlflow_log_param(p,config_node[[p]],run_id = active_experiment_run_uuid_,client = client_)
    }
  }
  mlflow_log_metric(experiment_peril_id_, 1,run_id = active_experiment_run_uuid_,client = client_)
  # Log a metric; metrics can be updated throughout the run
  mlflow_log_metric(experiment_peril_id_, 5,run_id = active_experiment_run_uuid_,client = client_)
  mlflow_log_metric(experiment_peril_id_, 2,run_id = active_experiment_run_uuid_,client = client_)
  mlflow_log_metric(experiment_peril_id_, 3,run_id = active_experiment_run_uuid_,client = client_)
  text = paste(toString(experiment_name_), ":", toString(experiment_peril_id_))
  info(logger = logger,message = text)
  # Log an artifact (base.log file)
  info(logger=logger,message = '*******Execaution of code ends*******')
  mlflow_log_artifact(file_name,client = client_,run_id = active_experiment_run_uuid_,artifact_path = file.path('log4j'))
  mlflow_end_run(
    status = "FINISHED",
    client = client_,run_id = active_experiment_run_uuid_)
  }
}
