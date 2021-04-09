## mlflow_use_case
#### Install the mlflow library, If you face issue in intalling follow the documenation [link](https://mlflow.org/docs/latest/quickstart.html#installing-mlflow)

#### after installing mlflow, Step's for execuating the code for Windows OS
  - make sure working dir path set to be ~/../mlflow_use_case
  - To expose mlflow ui
  - open cmd as admin level
  - activate the r-mlflow-1.14.1 enviornment
  - set working dir as mlflow_use_case project
  - command for mlflow server:
  ```{bash}
      mlflow server --host 0.0.0.0 --port 5000
  ```
  - if help need cmd on server exposing:
  ```{bash}
    mlflow server --help
  ```
  - after exposing the mlflow server then only **run main/main_init.R** file otherwise you will get **curl error**
  - make sure you change the experiment name while run for new experiment in main/main_init.R file

#### Mlflow have shared some tutorial examples (Python, R and JAVA) [link](https://mlflow.org/docs/latest/tutorials-and-examples/index.html) and specific to R API exmpale [R example link](https://github.com/mlflow/mlflow/tree/master/examples/r_wine)
 
#### For any issue or roadmap related details you can join the MLflow Community over Slack [link](https://join.slack.com/t/mlflow-users/shared_invite/zt-g6qwro5u-odM7pRnZxNX_w56mcsHp8g)  