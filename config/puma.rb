#https://gitlab.com/gitlab-org/gitlab-foss/-/blob/multi-threading/config/puma.rb.example

threads 4,4
workers 1
preload_app!