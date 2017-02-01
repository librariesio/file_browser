Rails.application.routes.draw do
  get '*path', :to => 'blob#show', :constraints => { :path => /.*/ }, format: :html
  root :to => 'blob#show'
end
