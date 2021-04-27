library(httr)


slack_message <- function(message_text,channel_post_url){
  resp <- POST(channel_post_url, body = list(text = as.character(message_text), encode = "json"))
  if (status_code(resp) != 200) {
    stop(
      sprintf(
        "Slack bot API request failed [%s]\n%s\n<%s>", 
        status_code(resp),
        parsed$message,
        parsed$documentation_url
      ),
      call. = FALSE
    )
  }
}
## how to use it
text_message <- "checking text example"
## Webhook URL from your slack bot app
model_run_tracking_channel_post_url <- "XXXXX"
slack_message(text_message,model_run_tracking_channel_post_url)