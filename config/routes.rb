Rails.application.routes.draw do
  post 'visualize_ruby', to: 'visualize_ruby#show'
  get 'visualize_ruby/version', to: "visualize_ruby#version"
end
