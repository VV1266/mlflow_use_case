# mlflow_use_case
## Install the mlflow library
## run the main_init.R


## Step's for execuating the code for Windows Server


### make sure working dir path set to be D:\Github\Cyber_IT_Pipelines_V4-master\Cyber_IT_MlFLow_Pipeline_V4
### To expose mlflow ui
#### open cmd as admin level
#### activate the r-mlflow-1.14.1 enviornment
#### set working dir as Cyber_IT_MlFLow_Pipeline_V4 project
#### command for mlflow server:
```{bash}
    mlflow server --host 0.0.0.0 --port 5000
```
####if help need cmd is:
```{bash}
    mlflow server --help
```
####after exposing the mlflow server then only **run main.R** file otherwise you will get **curl error**
####make sure you change the experiment name while run for new experiment in main.R file



 
