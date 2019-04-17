Rails.application.routes.draw do

	get 'employees/directory', :to => 'employees#directory'
	get 'employees/menu', :to => 'employees#menu'
	get 'employees/extension', :to => 'employees#extension'
	get 'employees/call', :to => 'employees#call'
	
  resources :employees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



end
