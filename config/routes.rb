Rails.application.routes.draw do

	match 'employees/directory', :to => 'employees#directory'
	match 'employees/menu', :to => 'employees#menu'
	match 'employees/extension', :to => 'employees#extension'
	match 'employees/call', :to => 'employees#call'
	
  resources :employees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



end
