Rails.application.routes.draw do
  post 'visualize_ruby', to: 'visualize_ruby#show'
  # post 'visualize_ruby/share', to: "share#create"
  # get 'visualize_ruby/share/:key', to: "share#show"
  get 'visualize_ruby/version', to: "visualize_ruby#version"
  # get "/:share_key", to: static("index.html")
end
